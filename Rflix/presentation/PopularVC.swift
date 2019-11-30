//
//  FirstViewController.swift
//  Rflix
//
//  Created by Preethi Valsalan on 11/18/19.
//  Copyright © 2019 Preethi Valsalan. All rights reserved.
//

import UIKit



class PopularVC: UIViewController, ISelectionListener {

    @IBOutlet weak var popularTable: CommonMovieTable!
    private var pageNo = 1;
    private var viewModel : PopularViewModel!
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = PopularViewModel(totalMovies: 40)
        popularTable.initialize(model: viewModel, selection: self)
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
        self.navigationItem.title =  "Most Popular Movies"
    }
    
    func populateData() {
        indicator.startAnimating()
        let refreshHandler: (Bool)->Void = { success in
            let genreResultHandler: (Bool)->Void = { success in
                self.indicator.stopAnimating()
                self.popularTable.reloadData()
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

