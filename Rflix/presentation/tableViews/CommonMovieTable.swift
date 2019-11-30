//
//  PopularMovieTable.swift
//  Rflix
//
//  Created by Preethi Valsalan on 11/23/19.
//  Copyright © 2019 Preethi Valsalan. All rights reserved.
//

import Foundation
import UIKit

class MovieTableCell: UITableViewCell {
    
    @IBOutlet weak var baseView: UIView!
  
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var Poster: UIImageView!
    
    @IBOutlet weak var genreLabel: UILabel!
    
}

class CommonMovieTable : UITableView, UITableViewDataSource, UITableViewDelegate {
    
    let cell_identifier = "MovieCell"
    private var viewModel : CommonMoviesVM!;
    private var onSelectListener : ISelectionListener!;
    
    func initialize(model: CommonMoviesVM, selection : ISelectionListener) {
        self.viewModel = model
        self.delegate = self
        self.dataSource = self
    
        self.onSelectListener = selection
        let itemCellNib = UINib(nibName: "MovieTableCellView", bundle: nil)
        register(itemCellNib, forCellReuseIdentifier: cell_identifier)
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getMovieCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cell_identifier, for: indexPath) as! MovieTableCell
        let row = indexPath.row
        
        let movieModel = viewModel.getMovie(index: row)

        cell.titleLabel.text = movieModel.title
        cell.yearLabel.text = "Released at : \(movieModel.getRelesedYear() )"
        cell.genreLabel.text = movieModel.getGenreString()
        if let posterImg = movieModel.poster {
            let thumbImgUrl = String(APIConstants.IMG_PATH_W92 + posterImg)
            let url = URL(string: thumbImgUrl)
            let data = try? Data(contentsOf : url! as URL)
            DispatchQueue.main.async {
                let image = UIImage(data : data! as Data)
                cell.Poster.image = image
                cell.Poster.layer.cornerRadius = 15
            }
        }
        else {
            cell.Poster.image = UIImage(named: "movie_avatar.png")
        }
        
        cell.Poster.layer.cornerRadius = 15
        cell.Poster.clipsToBounds = true
  
        var shdLoad = viewModel.shdLoadMore(index: row)
        if(shdLoad) {
            onSelectListener.loadMore()
        }
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = viewModel.getMovie(index: indexPath.row)
       onSelectListener.onSelect(movie: data)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 160
    }
    
}
