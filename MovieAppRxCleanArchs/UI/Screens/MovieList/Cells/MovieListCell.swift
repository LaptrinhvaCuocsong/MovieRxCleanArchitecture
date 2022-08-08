//
//  MovieListCell.swift
//  MovieAppRxCleanArchs
//
//  Created by hungnm98 on 27/07/2022.
//

import UIKit

class MovieListCell: UICollectionViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        configUI()
    }

    func configUI() {}

    func configCell(dataSource: MovieListCellDataSource) {}
}
