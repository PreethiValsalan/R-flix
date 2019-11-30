//
//  SecondViewController.swift
//  Rflix
//
//  Created by Preethi Valsalan on 11/18/19.
//  Copyright © 2019 Preethi Valsalan. All rights reserved.
//

import UIKit

class TopRatedVC: UIViewController, ISelectionListener {

    private var pageNo = 1;
    private var viewModel : TopRatedViewModel!
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var topRatedTable: CommonMovieTable!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = TopRatedViewModel(totalMovies: 40)
        topRatedTable.initialize(model: viewModel, selection: self)
        indicator.hidesWhenStopped = true
        populateData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.tabBar.isHidden = false
        self.navigationItem.title =  "Top Rated Movies"
    }
    
    func populateData() {
        indicator.startAnimating()
        let refreshHandler: (Bool)->Void = { success in
            let genreResultHandler: (Bool)->Void = { success in
                self.indicator.stopAnimating()
                self.topRatedTable.reloadData()
            }
            self.viewModel.getGenres(completionHandler: genreResultHandler)
        }
        viewModel.getData(pageNo: pageNo, completionHandler: refreshHandler)
    }
    
    func loadMore() {
        pageNo = pageNo + 1;
        populateData()
    }
    
    func onSelect(movie: MovieModel) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailsVC") as! MovieDetailsVC
        vc.movieModel = movie
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

