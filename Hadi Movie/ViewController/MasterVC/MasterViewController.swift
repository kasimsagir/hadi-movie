//
//  MasterViewController.swift
//  Hadi Movie
//
//  Created by Kasım on 5.11.2019.
//  Copyright © 2019 KS. All rights reserved.
//

import UIKit
import Kingfisher

class MasterViewController: UITableViewController {

    @IBOutlet weak var searchbar: UISearchBar!
    
    var detailViewController: DetailViewController? = nil
    var movies: [Movie] = [] {
        didSet{
            //self.filteredMovies = movies
            DispatchQueue.main.async {
                self.searchBar(self.searchbar, textDidChange: self.searchbar.text ?? "")
            }
        }
    }
    var filteredMovies: [Movie] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    var page = 1
    var isNewDataLoading = false
    var isEnd = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        getMovies(page)
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
        
    }
    
    // SCROLL DELEGATE
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        //Bottom Refresh
        if scrollView == tableView{
            if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height)
            {
                if !isNewDataLoading{
                    isNewDataLoading = true
                    page = page+1
                    getMovies(page)
                }
            }
        }
    }
    
    // SERVICES
    
    func getMovies(_ page: Int) {
        if !isEnd {
            NetworkManager.shared.getNewMovies(page: page) { (moviesResponse, isEnd, error) in
                if error != nil {
                    ViewUtils.showAlert(withController: self, title: "Error", message: error)
                }
                self.movies.append(contentsOf: moviesResponse ?? [])
                self.isEnd = isEnd ?? false
                self.isNewDataLoading = false
            }
        }
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let movie = filteredMovies[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.movie = movie
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
                detailViewController = controller
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMovies.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        let movie = filteredMovies[indexPath.row]
        cell.movieImageView.kf.setImage(with: URL(string: Utils.getPosterPath(movie.posterPath ?? "")), placeholder: nil, options: [.cacheOriginalImage], progressBlock: nil, completionHandler: nil)
        cell.titleLabel.text = movie.title
        cell.overviewLabel.text = movie.overview
        cell.dateLabel.text = Utils.changeMoviedbDateStringFormat(movie.releaseDate ?? "")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

}

extension MasterViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty  else { filteredMovies = movies; return }

        filteredMovies = movies.filter({ movie -> Bool in
            return movie.title!.lowercased().contains(searchText.lowercased())
        })
    }
}
