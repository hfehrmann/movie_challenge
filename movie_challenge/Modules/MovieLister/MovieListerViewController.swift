//
//  MovieListerViewController.swift
//  movie_challenge
//
//  Created by Laura Maldonado on 06-03-19.
//  Copyright © 2019 Hans Fehrmann. All rights reserved.
//

import UIKit

class MovieListerViewController: UIViewController {
    
    private var viewModel: MovieListerViewModel!

    override func viewDidLoad() {
        
    }
}

extension MovieListerViewController {
    
    static func instantiate(viewModel: MovieListerViewModel) -> MovieListerViewController {
        let storyboard = UIStoryboard(name: "MovieLister", bundle: nil)
        let standardViewController = storyboard.instantiateInitialViewController()
        let viewController = standardViewController as! MovieListerViewController
        viewController.viewModel = viewModel
        return viewController
    }
    
}
