//
//  MovieListerTableCell.swift
//  movie_challenge
//
//  Created by Laura Maldonado on 07-03-19.
//  Copyright © 2019 Hans Fehrmann. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MovieListerTableCell: UITableViewCell {

    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieImage: UIImageView!

    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!

    @IBOutlet weak var popularityImage: UIImageView!
    @IBOutlet weak var ratingImage: UIImageView!

    @IBOutlet weak var goButton: UIButton!

    private var viewModel: MovieListerTableCellViewModel!
    private var disposableBag = DisposeBag()

    override func awakeFromNib() {
        popularityImage.tintColor = .gray
        ratingImage.tintColor = .yellow
        goButton.setTitle(HFString.MovieLister.GoButton, for: .normal)
        movieImage.backgroundColor = .gray
        movieImage.layer.cornerRadius = 8
    }

    override func prepareForReuse() {
        disposableBag = DisposeBag()
    }

    func setBinding(viewModel: MovieListerTableCellViewModel) {
        self.viewModel = viewModel
        viewModel.title
            .bind(to: movieTitle.rx.text)
            .disposed(by: self.disposableBag)

        viewModel.rating
            .map({ String(format: "%.2f", $0) })
            .bind(to: ratingLabel.rx.text)
            .disposed(by: self.disposableBag)

        viewModel.popularity
            .map({ String(format: "%.2f", $0) })
            .bind(to: popularityLabel.rx.text)
            .disposed(by: self.disposableBag)

        viewModel
            .imageData
            .map({ UIImage(data: $0) })
            .bind(to: movieImage.rx.image)
            .disposed(by: self.disposableBag)
    }



}
