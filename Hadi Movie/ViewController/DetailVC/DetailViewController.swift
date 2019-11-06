//
//  DetailViewController.swift
//  Hadi Movie
//
//  Created by Kasım on 5.11.2019.
//  Copyright © 2019 KS. All rights reserved.
//

import UIKit

class DetailViewController: UITableViewController {

    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var backPoster: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var kindOfMovieLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var castCollectionView: UICollectionView!


    func configureView() {
        // Update the user interface for the detail item.
        if let movieId = movie?.id {
            // call detail with movieId
            getDetails(movieId)
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
    
    var movieDetail: MovieDetail? {
        didSet{
            setUI()
        }
    }
    
    var moviesCast = [Cast](){
        didSet {
            DispatchQueue.main.async {
                self.castCollectionView.reloadData()
            }
        }
    }
    
    var genreString: String? {
        didSet{
            DispatchQueue.main.async {
                self.kindOfMovieLabel.text = self.genreString
            }
        }
    }

    func setUI(){
        if let genres = movieDetail?.genres {
            genreString = ""
            for item in genres {
                genreString = "\(genreString!), \(item.name!)"
            }
            genreString?.removeFirst()
            genreString?.removeFirst()
        }
        
        DispatchQueue.main.async {
            self.backPoster.kf.setImage(with: URL(string: Utils.getHighConsPosterPath(self.movieDetail?.backdrop_path ?? "")), placeholder: nil, options: [.cacheOriginalImage], progressBlock: nil, completionHandler: nil)
            self.posterImage.kf.setImage(with: URL(string: Utils.getHighConsPosterPath(self.movieDetail?.poster_path ?? "")), placeholder: nil, options: [.cacheOriginalImage] , progressBlock: nil, completionHandler: nil)
            
            self.descriptionLabel.text = self.movieDetail?.overview
            self.titleLabel.text = self.movieDetail?.original_title
            self.rateLabel.text = String(describing: self.movieDetail?.vote_average ?? 0.0)
        }
    }
    
    // SERVICES
    func getDetails(_ movieId : Int) {
        NetworkManager.shared.getMovieDetail(movieId: movieId) { (movieDetailResponse, error) in
            if error != nil {
                ViewUtils.showAlert(withController: self, title: "Hata", message: error)
            }
            self.movieDetail = movieDetailResponse
            self.getCast(movieId)
        }
    }
    
    func getCast(_ movieId : Int) {
        NetworkManager.shared.getMovieCast(movieId: movieId, completion: {(castList, error) in
            if error != nil {
                ViewUtils.showAlert(withController: self, title: "Hata", message: error)
            }
            self.moviesCast = castList ?? []
        })
    }
}

extension DetailViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviesCast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.register(UINib(nibName: "CastCollectionCell", bundle: nil), forCellWithReuseIdentifier: "CastCollectionCell")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CastCollectionCell", for: indexPath) as! CastCollectionCell
        let cast = moviesCast[indexPath.row]
        cell.castCollectionImageView.kf.setImage(with: URL(string: Utils.getPosterPath(cast.profile_path ?? "")), placeholder: nil, options: [.cacheOriginalImage], progressBlock: nil,completionHandler: nil)
        cell.castCollectionNameLabel.text = cast.name
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) ->
        CGSize {
            let width = collectionView.frame.width/3
            let height = collectionView.frame.height-8
            return CGSize(width: width, height: height)
    }
}
