//
//  BaseVC.swift
//  MovieAppRxCleanArchs
//
//  Created by hungnm98 on 09/06/2022.
//

import UIKit
import SideMenuSwift

class BaseVC: UIViewController {
    var sideMenuVC: UIViewController? {
        didSet {
            guard let menu = sideMenuVC else { return }
            Application.shared.baseSideMenu.menuViewController = menu
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        binding()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }

    func setupUI() {}

    func binding() {}
    
    @objc func doBack() {
        navigationController?.popViewController(animated: true)
    }

    @objc func doDismiss() {
        dismiss(animated: true)
    }
    
    func showMenu(animated: Bool = true) {
        guard sideMenuVC != nil else { return }
        sideMenuController?.revealMenu(animated: animated, completion: nil)
    }
    
    func hideMenu(animated: Bool = true) {
        sideMenuController?.hideMenu(animated: animated, completion: nil)
    }
    
    // MARK: - Setup NavigationBar
    
    func canBack() -> Bool {
        return false
    }

    func canDismiss() -> Bool {
        return false
    }
    
    func leftBarButtonItems() -> [UIBarButtonItem] {
        return []
    }
    
    func rightBarButtonItems() -> [UIBarButtonItem] {
        return []
    }

    func setupNavigationBar() {
        guard let navBar = navigationController?.navigationBar else { return }
        // Setup appearance
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.backgroundColor = Colors.tintColor
        standardAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
                                                  NSAttributedString.Key.font: Fonts.Roboto.medium(with: 18)]
        let compactAppearance = standardAppearance.copy()
        navBar.standardAppearance = standardAppearance
        navBar.scrollEdgeAppearance = standardAppearance
        navBar.compactAppearance = compactAppearance
        if #available(iOS 15.0, *) {
            navBar.compactScrollEdgeAppearance = compactAppearance
        }
        // Setup bar buttons
        if navigationItem.leftBarButtonItems == nil {
            navigationItem.leftBarButtonItems = [UIBarButtonItem]()
        }
        navigationItem.leftBarButtonItems?.removeAll()
        if canBack() {
            let btnBack = UIBarButtonItem(image: Images.Button.icBack, style: .plain, target: self, action: #selector(doBack))
            navigationItem.leftBarButtonItems?.append(btnBack)
        }
        if canDismiss() {
            let btnDismiss = UIBarButtonItem(image: Images.Button.icClose, style: .plain, target: self, action: #selector(doDismiss))
            navigationItem.leftBarButtonItems?.append(btnDismiss)
        }
        leftBarButtonItems().forEach { barButtonItem in
            navigationItem.leftBarButtonItems?.append(barButtonItem)
        }
        if navigationItem.rightBarButtonItems == nil {
            navigationItem.rightBarButtonItems = [UIBarButtonItem]()
        }
        navigationItem.rightBarButtonItems?.removeAll()
        rightBarButtonItems().forEach { barButtonItem in
            navigationItem.rightBarButtonItems?.append(barButtonItem)
        }
    }
}
