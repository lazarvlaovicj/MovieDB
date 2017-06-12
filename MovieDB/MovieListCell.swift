//
//  MovieListCell.swift
//  MovieDB
//
//  Created by PRO on 2/26/17.
//  Copyright © 2017 Lazar. All rights reserved.
//

import UIKit

class MovieListCell: UITableViewCell {
    
    @IBOutlet weak var movieLbl: UILabel!
    @IBOutlet weak var movieImage: UIImageView!
    
    func configCell (movies: Movies) {
        
        self.movieLbl.text = movies.title
        let imageURL = URL(string: "https://image.tmdb.org/t/p/w500\(movies.posterPath)")
        
        DispatchQueue.global().async {
            do{
                let data = try Data(contentsOf: imageURL!)
                DispatchQueue.main.sync {
                    self.movieImage.image = UIImage(data: data)
                }
            }catch{
                print(error.localizedDescription)
            }
        }
    }
}
