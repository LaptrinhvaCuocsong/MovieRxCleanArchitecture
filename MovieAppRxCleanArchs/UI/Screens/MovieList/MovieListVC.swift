//
//  MovieListVC.swift
//  MovieAppRxCleanArchs
//
//  Created by hungnm98 on 06/06/2022.
//

import RxCocoa
import RxSwift
import SideMenuSwift
import UIKit

class MovieListVC: BaseVC {
    @IBOutlet private var collectionView: UICollectionView!

    private var viewModel: MovieListVM
    private let disposeBag = DisposeBag()

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

    override func setupUI() {
        view.backgroundColor = Colors.defaultScreenBackgroundColor
        navigationItem.title = Strings.MovieList.title
        sideMenuVC = ProfileVC(viewModel: ProfileVM(dataSource: DefaultProfileDataSource(),
                                                    coordinator: ProfileCoordinator(navigationController: navigationController)))
    }

    override func binding() {
        let input = MovieListVM.Input(changeLayoutTrigger: btnChangeLayout.rx.tap.asDriver())
        let output = viewModel.transform(input: input)

        output.movies
            .drive { [weak self] movies in
                print(movies)
            }
            .disposed(by: disposeBag)
        
        output.error
            .drive(onNext: { error in
                print(error)
            })
            .disposed(by: disposeBag)

        output.isLayoutByList
            .drive(onNext: { [unowned self] isLayoutByList in
                self.btnChangeLayout.image = isLayoutByList ? Images.Button.icGrid : Images.Button.icList
            })
            .disposed(by: disposeBag)

        btnMenu.rx.tap.bind { [weak self] _ in
            guard let self = self else { return }
            self.showMenu()
        }
        .disposed(by: disposeBag)
    }
}
