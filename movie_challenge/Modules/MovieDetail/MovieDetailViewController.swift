//
//  MovieDetailViewController.swift
//  movie_challenge
//
//  Created by Laura Maldonado on 08-03-19.
//  Copyright © 2019 Hans Fehrmann. All rights reserved.
//

import UIKit
import RxSwift

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var movieLabel: UILabel!
    @IBOutlet weak var movieImage: UIImageView!

    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var popularityImage: UIImageView!
    @IBOutlet weak var ratingImage: UIImageView!


    @IBOutlet weak var overviewTextView: UITextView!
    
    private var disposableBag = DisposeBag()
    private var viewModel: MovieDetailViewModel!

    init(viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "MovieDetail", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        setupBindings()
    }

    override func viewWillAppear(_ animated: Bool) {
        setupUI()
    }

    private func setupUI() {
        ratingImage.tintColor = .rating
        popularityImage.tintColor = .popularity
    }

    private func setupBindings() {
        viewModel.title
            .bind(to: movieLabel.rx.text)
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

        viewModel
            .overview
            .bind(to: overviewTextView.rx.text)
            .disposed(by: disposableBag)
    }
}
