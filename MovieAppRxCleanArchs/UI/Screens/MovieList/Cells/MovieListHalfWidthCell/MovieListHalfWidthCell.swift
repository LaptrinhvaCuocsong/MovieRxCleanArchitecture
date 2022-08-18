//
//  MovieListHalfWidthCell.swift
//  MovieAppRxCleanArchs
//
//  Created by hungnm98 on 24/07/2022.
//

import UIKit

class MovieListHalfWidthCell: MovieListCell {
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    
    override func configUI() {
        titleLabel.font = Fonts.Roboto.medium(with: 16)
        titleLabel.textColor = Colors.blackColor
        titleLabel.text = ""
        titleLabel.numberOfLines = 2
    }
    
    override func configCell(dataSource: MovieListCellDataSource) {
        guard let movie = dataSource.movie else {
            return
        }
        titleLabel.text = movie.title
        titleLabel.sizeToFit()
        imageView.sdSetMovieImage(path: dataSource.movie?.posterPath ?? "", fileSizeType: .poster, completion: nil)
        layoutIfNeeded()
    }
}
