//
//  MovieListFullWidthCell.swift
//  MovieAppRxCleanArchs
//
//  Created by hungnm98 on 15/07/2022.
//

import UIKit

class MovieListFullWidthCell: MovieListCell {
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var sortInfoStackView: UIStackView!
    @IBOutlet private var overviewLabel: UILabel!
    @IBOutlet private var favoriteButton: UIButton!
    @IBOutlet private var overviewTitleLabel: UILabel!

    private var tileViews: [String: TileView] = [:]

    override func layoutSubviews() {
        super.layoutSubviews()
        tileViews.values.forEach({ $0.minSpacing = 10 })
    }

    override func configUI() {
        titleLabel.font = Fonts.Roboto.medium(with: 16)
        titleLabel.textColor = Colors.blackColor
        titleLabel.text = ""
        sortInfoStackView.subviews.forEach({ $0.removeFromSuperview() })
        overviewTitleLabel.font = Fonts.Roboto.regular(with: 14)
        overviewTitleLabel.textColor = Colors.redColor
        overviewTitleLabel.text = Strings.Label.overview
        overviewLabel.numberOfLines = 3
        overviewLabel.font = Fonts.Roboto.regular(with: 14)
        overviewLabel.textColor = Colors.greyColor
        overviewLabel.text = ""
        tileViews["release_date"] = addTileView(title: Strings.Label.releaseDate, titleFont: Fonts.Roboto.regular(with: 14), titleColor: Colors.blackColor, value: " ", valueFont: Fonts.Roboto.regular(with: 14), valueColor: Colors.redColor, valueAlignment: .left, into: sortInfoStackView)
        tileViews["rating"] = addTileView(title: Strings.Label.rating, titleFont: Fonts.Roboto.regular(with: 14), titleColor: Colors.blackColor, value: " ", valueFont: Fonts.Roboto.regular(with: 14), valueColor: Colors.redColor, valueAlignment: .left, into: sortInfoStackView)
        favoriteButton.setTitle("", for: .normal)
    }

    override func configCell(dataSource: MovieListCellDataSource) {
        titleLabel.text = dataSource.movie?.title
        tileViews["release_date"]?.valueLabel = dataSource.movie?.releaseDate
        tileViews["rating"]?.valueLabel = String(format: "%.1f", dataSource.movie?.voteAverage ?? 0.0) + "/10.0"
        overviewLabel.text = dataSource.movie?.overview
        imageView.sdSetMovieImage(path: dataSource.movie?.posterPath ?? "", fileSizeType: .poster, completion: nil)
    }
}
