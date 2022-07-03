//
//  ProfileVC.swift
//  MovieAppRxCleanArchs
//
//  Created by hungnm98 on 19/06/2022.
//

import UIKit

class ProfileVC: BaseVC {
    private var viewModel: ProfileVM
    
    init(viewModel: ProfileVM) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: Self.self), bundle: Bundle.main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }
}
