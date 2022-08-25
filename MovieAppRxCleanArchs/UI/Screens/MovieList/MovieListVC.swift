//
//  MovieListVC.swift
//  MovieAppRxCleanArchs
//
//  Created by hungnm98 on 06/06/2022.
//

import Domain
import RxCocoa
import RxSwift
import SideMenuSwift
import UIKit

class MovieListVC: BaseVC {
    @IBOutlet private var collectionView: UICollectionView!

    private var viewModel: MovieListVM
    private let disposeBag = DisposeBag()
    private let pullToRefreshTrigger = BehaviorSubject<Void>(value: ())
    private let loadMoreTrigger = PublishSubject<Void>()

    init(viewModel: MovieListVM) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: Self.self), bundle: Bundle.main)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var btnChangeLayout: UIBarButtonItem = {
        let btn = UIBarButtonItem(image: Images.Button.icGrid, style: .plain, target: nil, action: nil)
        return btn
    }()

    lazy var btnMenu: UIBarButtonItem = {
        let btn = UIBarButtonItem(image: Images.Button.icMenu, style: .plain, target: nil, action: nil)
        return btn
    }()

    override func leftBarButtonItems() -> [UIBarButtonItem] {
        return [btnMenu]
    }

    override func rightBarButtonItems() -> [UIBarButtonItem] {
        return [btnChangeLayout]
    }

    private lazy var collectionFullWidthLayout: UICollectionViewLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: collectionView.frame.width, height: 180.0)
        return flowLayout
    }()

    private lazy var collectionHalfWidthLayout: UICollectionViewLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        let itemWidth = (collectionView.frame.width - 16.0) / 2
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 60)
        flowLayout.minimumLineSpacing = 16.0
        flowLayout.minimumInteritemSpacing = 16.0
        flowLayout.sectionInset = .zero
        return flowLayout
    }()

    override func setupUI() {
        view.backgroundColor = Colors.defaultScreenBackgroundColor
        navigationItem.title = Strings.MovieList.title
        sideMenuVC = ProfileVC(viewModel: ProfileVM(dataSource: DefaultProfileDataSource(),
                                                    coordinator: ProfileCoordinator(navigationController: navigationController)))
        collectionView.registerCells(types: [
            MovieListFullWidthCell.self,
            MovieListHalfWidthCell.self,
        ])
        collectionView.collectionViewLayout = collectionFullWidthLayout
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.setupPullToRefresh { [unowned self] in
            pullToRefreshTrigger.onNext(())
        }
        collectionView.setupLoadMore { [unowned self] in
            !viewModel.checkIsEndLoadMore()
        } loadMoreAction: { [unowned self] in
            loadMoreTrigger.onNext(())
        }
    }

    override func binding() {
        let viewDidLoadTrigger = Driver.just(()).delay(.milliseconds(300))

        let input = MovieListVM.Input(changeLayoutTrigger: btnChangeLayout.rx.tap.asDriver(),
                                      viewDidLoadTrigger: viewDidLoadTrigger,
                                      pullToRefreshTrigger: pullToRefreshTrigger.asDriverOnErrorJustComplete(),
                                      loadMoreTrigger: loadMoreTrigger.asDriverOnErrorJustComplete())
        let output = viewModel.transform(input: input)

        output.movies
            .drive(onNext: { [weak self] result in
                guard let self = self else { return }
                self.handleMovies(result: result)
            })
            .disposed(by: disposeBag)

        output.isLayoutByList
            .skip(1)
            .drive(onNext: { [unowned self] isLayoutByList in
                self.btnChangeLayout.image = isLayoutByList ? Images.Button.icGrid : Images.Button.icList
                self.collectionView.reloadData()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [unowned self] in
                    self.collectionView.setCollectionViewLayout(isLayoutByList ? collectionFullWidthLayout : collectionHalfWidthLayout, animated: true)
                }
            })
            .disposed(by: disposeBag)

        output.isLoading
            .drive { isLoading in
                Helper.showHUD(isLoading)
            }
            .disposed(by: disposeBag)

        btnMenu.rx.tap.bind { [weak self] _ in
            guard let self = self else { return }
            self.showMenu()
        }
        .disposed(by: disposeBag)
    }

    private func handleMovies(result: Result<[Movie], Error>) {
        collectionView.endPullToRefresh()
        collectionView.endLoadMore()
        switch result {
        case .success:
            collectionView.reloadData()
        case let .failure(error):
            showError(error)
        }
    }
}

extension MovieListVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getMovies().count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let bundleIdentifier = viewModel.bundleIdentifier(forCellAt: indexPath)
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: bundleIdentifier, for: indexPath) as? MovieListCell {
            if let dataSource = viewModel.cellDataSource(forCellAt: indexPath) {
                cell.configCell(dataSource: dataSource)
            }
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}
