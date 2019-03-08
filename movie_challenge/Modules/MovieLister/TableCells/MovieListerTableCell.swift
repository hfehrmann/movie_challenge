//
//  MovieListerTableCell.swift
//  movie_challenge
//
//  Created by Laura Maldonado on 07-03-19.
//  Copyright © 2019 Hans Fehrmann. All rights reserved.
//

import UIKit
import RxSwift

class MovieListerTableCell: UITableViewCell {

    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieImage: UIImageView!

    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!

    @IBOutlet weak var goButton: UIButton!

    private var viewModel: MovieListerTableCellViewModel!
    private var disposableBag = DisposeBag()

    override func prepareForReuse() {
        disposableBag = DisposeBag()
    }

    func setBinding(viewModel: MovieListerTableCellViewModel) {
        self.viewModel = viewModel
        
    }



}
