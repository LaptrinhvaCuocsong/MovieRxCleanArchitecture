//
//  UIScrollView+Ext.swift
//  MovieAppRxCleanArchs
//
//  Created by Nguyen Manh Hung on 17/08/2022.
//

import RxSwift
import UIKit

private var kRefreshControllerKey = "kRefreshControllerKey"
private var kLoadMoreControllerKey = "kLoadMoreControllerKey"

extension UIScrollView {
    private var refreshController: RefreshController? {
        get {
            if let refreshController = objc_getAssociatedObject(self, &kRefreshControllerKey) as? RefreshController {
                return refreshController
            }
            return nil
        }
        set {
            objc_setAssociatedObject(self, &kRefreshControllerKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    private var loadMoreController: LoadMoreController? {
        get {
            if let loadMoreController = objc_getAssociatedObject(self, &kLoadMoreControllerKey) as? LoadMoreController {
                return loadMoreController
            }
            return nil
        }
        set {
            objc_setAssociatedObject(self, &kLoadMoreControllerKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    func isNearBottomEdge(edgeOffset: CGFloat = 20.0) -> Bool {
        return contentOffset.y + frame.size.height + edgeOffset > contentSize.height && contentSize.height > frame.size.height
    }

    func isNearTopEdge(edgeOffset: CGFloat = 100.0) -> Bool {
        return contentOffset.y < edgeOffset
    }

    func setupPullToRefresh(refreshControlCustomize: ((UIRefreshControl) -> Void)? = nil,
                            refreshingAction: (() -> Void)?) {
        let refreshControl = UIRefreshControl()
        refreshControlCustomize?(refreshControl)
        refreshController = RefreshController(refreshControl: refreshControl, scrollView: self, refreshingAction: refreshingAction)
        refreshController?.setupPullToRefresh()
    }

    func endPullToRefresh() {
        refreshController?.endPullToRefresh()
    }

    func setupLoadMore(activityIndicatorCustomize: ((UIActivityIndicatorView) -> Void)? = nil,
                       loadMoreEnable: (() -> Bool)?,
                       loadMoreAction: (() -> Void)?) {
        let loadMoreView = UIView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: 40))
        loadMoreView.backgroundColor = .clear
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadMoreView.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: loadMoreView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: loadMoreView.centerYAnchor),
        ])
        activityIndicatorCustomize?(activityIndicator)
        addSubview(loadMoreView)
        loadMoreController = LoadMoreController(scrollView: self,
                                                loadMoreView: loadMoreView,
                                                activitiIndicator: activityIndicator,
                                                loadMoreEnable: loadMoreEnable,
                                                loadMoreAction: loadMoreAction)
    }

    func endLoadMore() {
        loadMoreController?.endLoadMore()
    }
}

class RefreshController: NSObject {
    weak var refreshControl: UIRefreshControl?
    weak var scrollView: UIScrollView?
    var refreshingAction: (() -> Void)?

    init(refreshControl: UIRefreshControl?, scrollView: UIScrollView?, refreshingAction: (() -> Void)?) {
        self.refreshControl = refreshControl
        self.scrollView = scrollView
        self.refreshingAction = refreshingAction
        super.init()
    }

    func setupPullToRefresh() {
        guard let refreshControl = refreshControl else {
            return
        }
        refreshControl.addTarget(self, action: #selector(startRefreshing), for: .valueChanged)
        scrollView?.addSubview(refreshControl)
    }

    @objc private func startRefreshing() {
        refreshControl?.beginRefreshing()
        refreshingAction?()
    }

    func endPullToRefresh() {
        refreshControl?.endRefreshing()
    }
}

class LoadMoreController: NSObject {
    weak var scrollView: UIScrollView?
    weak var loadMoreView: UIView?
    weak var activitiIndicator: UIActivityIndicatorView?
    var loadMoreEnable: (() -> Bool)?
    var loadMoreAction: (() -> Void)?
    private var bottomInset: CGFloat = 0.0
    private let disposeBag = DisposeBag()

    init(scrollView: UIScrollView?,
         loadMoreView: UIView?,
         activitiIndicator: UIActivityIndicatorView?,
         loadMoreEnable: (() -> Bool)?,
         loadMoreAction: (() -> Void)?) {
        self.scrollView = scrollView
        self.loadMoreView = loadMoreView
        self.activitiIndicator = activitiIndicator
        self.loadMoreEnable = loadMoreEnable
        self.loadMoreAction = loadMoreAction
        super.init()
        loadMoreView?.isHidden = true
        bottomInset = scrollView?.contentInset.bottom ?? 0
        binding()
    }

    private func binding() {
        scrollView?.rx.didScroll
            .asObservable()
            .subscribe({ [weak self] _ in
                guard let self = self else { return }
                self.loadMoreView?.frame = CGRect(x: 0,
                                                  y: self.scrollView?.contentSize.height ?? 0,
                                                  width: self.scrollView?.frame.width ?? 0,
                                                  height: 40)
                if self.loadMoreEnable?() == true, self.scrollView?.isNearBottomEdge() == true {
                    self.startLoadMore()
                    self.loadMoreAction?()
                }
            })
            .disposed(by: disposeBag)
    }

    private func startLoadMore() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.scrollView?.contentInset.bottom = self.bottomInset + 40
            self.activitiIndicator?.startAnimating()
            self.loadMoreView?.isHidden = false
        }
    }

    func endLoadMore() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.scrollView?.contentInset.bottom = self.bottomInset
            self.activitiIndicator?.stopAnimating()
            self.loadMoreView?.isHidden = true
        }
    }
}
