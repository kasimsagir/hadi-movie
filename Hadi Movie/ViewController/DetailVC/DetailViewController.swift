//
//  DetailViewController.swift
//  Hadi Movie
//
//  Created by Kasım on 5.11.2019.
//  Copyright © 2019 KS. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!


    func configureView() {
        // Update the user interface for the detail item.
        if let movieId = movie?.id {
            // call detail with movieId
            if let label = detailDescriptionLabel {
                label.text = String(movieId)
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
    }

    var movie: Movie? {
        didSet {
            // Update the view.
            configureView()
        }
    }


}

