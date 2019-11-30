//
//  MovieDetailsVC.swift
//  Rflix
//
//  Created by Preethi Valsalan on 11/24/19.
//  Copyright © 2019 Preethi Valsalan. All rights reserved.
//

import UIKit

class CastTableCell: UITableViewCell {
    
    @IBOutlet weak var castPhoto: UIImageView!
    
    @IBOutlet weak var charectorLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
}
class DescriptionTableCell: UITableViewCell {
    
    @IBOutlet weak var DescText: UILabel!
}

class MovieDetailsVC : UIViewController, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {

    
    let cell_identifier = "CastCell"
    let movie_cell_identifier = "RecommendedCell"
    let desc_cell_identifier = "DescCell"
    
    private var viewModel : MovieDetailsVM!
    
    @IBOutlet weak var topView: UIView!
    var movieModel : MovieModel!
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var releasedYear: UILabel!
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var directorLbl: UILabel!
    @IBOutlet weak var studioLbl: UILabel!
    @IBOutlet weak var homePageBtn: UIButton!
    
    @IBOutlet weak var imdbButton: UIButton!
    @IBOutlet weak var castTable: UITableView!
    private let topInset : CGFloat = 150
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MovieDetailsVM()
        castTable.delegate = self
        castTable.dataSource = self
        
        if #available(iOS 11.0, *) {
            self.automaticallyAdjustsScrollViewInsets = true
        }
        else {
            self.automaticallyAdjustsScrollViewInsets = false
        }
     //   tableHeight.constant = self.view.frame.height-64
        self.castTable.contentInset = UIEdgeInsetsMake(topInset, 0, 0, 0)
        self.castTable.bounces = true
 
        let descCellNib = UINib(nibName: "MovieDescriptionCellView", bundle: nil)
        castTable.register(descCellNib, forCellReuseIdentifier: desc_cell_identifier)
        
        let castCellNib = UINib(nibName: "CastTableCellView", bundle: nil)
        castTable.register(castCellNib, forCellReuseIdentifier: cell_identifier)
        
        let movieCellNib = UINib(nibName: "CastTableCellView", bundle: nil)
        castTable.register(movieCellNib, forCellReuseIdentifier: movie_cell_identifier)
        indicator.hidesWhenStopped = true
        
        populateData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        viewModel.release()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.topItem?.title = " "
        self.tabBarController?.tabBar.isHidden = true
        self.navigationItem.title =  movieModel.title
    }
    
    func populateData() {
        indicator.startAnimating()
        let refreshHandler: (Bool)->Void = { success in
            self.indicator.stopAnimating()
            self.setData()
        }
        viewModel.getData(movieId: movieModel.id, completionHandler: refreshHandler)
    }
    
    func setData() {
        let data = viewModel.movie
        if let posterImg = movieModel.poster {
            let thumbImgUrl = String(APIConstants.IMG_PATH_W92 + posterImg)
            let url = URL(string: thumbImgUrl)
            let data = try? Data(contentsOf : url! as URL)
            DispatchQueue.main.async {
                let image = UIImage(data : data! as Data)
                self.movieImage.image = image
                self.movieImage.layer.cornerRadius = 15
            }
        }
        else {
            movieImage.image = UIImage(named: "movie_avatar.png")
        }
        releasedYear.text = "Released at : \(movieModel.getRelesedYear() )"
        directorLbl.text = "Director : \(data?.director ?? " ")"
        studioLbl.text =  "Studio : \(data?.studio ?? " ")"
        genre.text = movieModel.getGenreString()
        castTable.reloadData()
    }
    
    @IBAction func showHomePage(_ sender: UIButton) {
        if let homePage = viewModel.movie.homePage {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "WebVC") as! WebVC
            vc.webUrl = homePage
            vc.pageName = "Home Page"
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func showImdbPage(_ sender: UIButton) {
       
        if let imdbId = viewModel.movie.imdbId {
            let imdbPage = APIConstants.IMDB_PATH + imdbId
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "WebVC") as! WebVC
            vc.webUrl = imdbPage
            vc.pageName = "IMDb Page"
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if(viewModel.movie == nil) {
            return 0
        }
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(viewModel.movie == nil) {
            return 0
        }
        if(section == 0) {
            return 1
        }
        else if(section == 1) {
            return viewModel.getCastCount()
        }
        return viewModel.getRecommendationCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        if(section == 0) {
            let descCell = tableView.dequeueReusableCell(withIdentifier: desc_cell_identifier, for: indexPath) as! DescriptionTableCell

            descCell.DescText.text = viewModel.movie.summary
            return descCell
        }
        else if(section == 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: cell_identifier, for: indexPath) as! CastTableCell
            let row = indexPath.row
            
            let castModel = viewModel.getCast(index: row)
            
            cell.nameLabel.text = castModel.name
            cell.charectorLabel.text = "Charector : "+castModel.character
            
            if let posterImg = castModel.profilePic {
                let thumbImgUrl = String(APIConstants.IMG_PATH_W92 + posterImg)
                let url = URL(string: thumbImgUrl)
                let data = try? Data(contentsOf : url! as URL)
                DispatchQueue.main.async {
                    let image = UIImage(data : data! as Data)
                    cell.castPhoto.image = image
                    cell.castPhoto.layer.cornerRadius = 15
                }
            }
            else {
                cell.castPhoto.image = UIImage(named: "movie_avatar.png")
            }
            
            cell.castPhoto.layer.cornerRadius = 15
            cell.castPhoto.clipsToBounds = true
            
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: movie_cell_identifier, for: indexPath) as! CastTableCell
        let row = indexPath.row
        
        let movieModel = viewModel.getRecommendation(index: row)
        
        cell.nameLabel.text = movieModel.title
        cell.charectorLabel.text = "Released Year : "+movieModel.getRelesedYear()
        
        if let posterImg = movieModel.poster {
            let thumbImgUrl = String(APIConstants.IMG_PATH_W92 + posterImg)
            let url = URL(string: thumbImgUrl)
            let data = try? Data(contentsOf : url! as URL)
            DispatchQueue.main.async {
                let image = UIImage(data : data! as Data)
                cell.castPhoto.image = image
                cell.castPhoto.layer.cornerRadius = 15
            }
        }
        else {
            cell.castPhoto.image = UIImage(named: "movie_avatar.png")
        }
        
        cell.castPhoto.layer.cornerRadius = 15
        cell.castPhoto.clipsToBounds = true
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 0) {
            return "SUMMARY"
        }
        else if(section == 1) {
            return "CASTS"
        }
        return "RECOMMENDED MOVIES"
    }
}
