//
//  MovieFavoriteVC.swift
//  MovieAppRxCleanArchs
//
//  Created by hungnm98 on 09/06/2022.
//

import UIKit

class MovieFavoriteVC: BaseVC {
    private var viewModel: MovieFavoriteVM

    init(viewModel: MovieFavoriteVM) {
        self.viewModel = viewModel
        super.init(nibName: String(describing: Self.self), bundle: Bundle.main)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
