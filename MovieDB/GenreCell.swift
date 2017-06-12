//
//  GenreCell.swift
//  MovieDB
//
//  Created by PRO on 2/25/17.
//  Copyright © 2017 Lazar. All rights reserved.
//

import UIKit

class GenreCell: UITableViewCell {
    
    @IBOutlet weak var genreLbl: UILabel!
    
    func cellConfig(genres: Genres) {
        self.genreLbl.text = " "+genres.name
    }
    
}
