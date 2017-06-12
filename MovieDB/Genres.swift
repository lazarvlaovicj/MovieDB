//
//  Genres.swift
//  MovieDB
//
//  Created by PRO on 2/25/17.
//  Copyright © 2017 Lazar. All rights reserved.
//

import Foundation

class Genres {
    
    private var _id: String!
    private var _name: String!
    
    var id: String {
        if _id == nil {
            return ""
        }
        return _id
    }
    var name: String {
        if _name == nil {
            return ""
        }
        return _name
    }
    
    init(genreDict: Dictionary<String, AnyObject>) {
        
        if let name = genreDict["name"] as? String {
            self._name = name
        }
        if let id = genreDict["id"] as? Int {
            self._id = "\(id)"
        }
        
    }
    
}
