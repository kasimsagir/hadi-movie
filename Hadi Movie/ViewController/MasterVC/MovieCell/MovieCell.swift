//
//  MovieCell.swift
//  Hadi Movie
//
//  Created by Kasım on 6.11.2019.
//  Copyright © 2019 KS. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    override func awakeFromNib() {
        
    }
}
