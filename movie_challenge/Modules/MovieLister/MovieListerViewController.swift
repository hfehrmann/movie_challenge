//
//  MovieListerViewController.swift
//  movie_challenge
//
//  Created by Laura Maldonado on 06-03-19.
//  Copyright © 2019 Hans Fehrmann. All rights reserved.
//

import UIKit
import RxSwift

class MovieListerViewController: UIViewController {
    
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!

    private var disposableBag = DisposeBag()
    private var viewModel: MovieListerViewModel!

    init(viewModel: MovieListerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: "MovieLister", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        setupUI()
        setupBindings()
    }

    private func setupUI() {
        self.tableView.tableHeaderView = nil
        self.tableView.tableFooterView = nil
    }

    private func setupBindings() {
        let defaultSegmentIndex = 0
        segment.removeAllSegments()
        viewModel.segmentTitle.bind(onNext: {[unowned self] (first, second) in
            self.segment.insertSegment(withTitle: first, at: 0, animated: false)
            self.segment.insertSegment(withTitle: second, at: 1, animated: false)
            self.segment.selectedSegmentIndex = defaultSegmentIndex
        }).disposed(by: self.disposableBag)
    }
}
