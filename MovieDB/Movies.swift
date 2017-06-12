//
//  Movies.swift
//  MovieDB
//
//  Created by PRO on 2/26/17.
//  Copyright © 2017 Lazar. All rights reserved.
//

import Foundation
import Alamofire

class Movies {
    
    private var _title: String!
    private var _id: String!
    private var _voteAverage: String!
    private var _overview: String!
    private var _posterPath: String!
    
    var posterPath: String {
        if _posterPath == nil{
            return ""
        }
        return _posterPath
    }
    
    var overview: String {
        if _overview == nil{
            return ""
        }
        return _overview
    }
    
    var voteAverage: String {
        if _voteAverage == nil{
            return ""
        }
        return _voteAverage
    }
    
    var title: String {
        if _title == nil{
            return ""
        }
        return _title
    }
    
    var id: String {
        if _id == nil{
            return ""
        }
        return _id
    }
    
    init(movieDict: Dictionary<String, AnyObject>) {
        
        if let id = movieDict["id"] as? Int {
            self._id = "\(id)"
        }
        
        if let title = movieDict["title"] as? String {
            self._title = title
        }
        
        if let voteAverage = movieDict["vote_average"] as? Double {
            self._voteAverage = "\(voteAverage)"
        }
        
        if let overview = movieDict["overview"] as? String {
            self._overview = overview
        }
        
        if let posterPath = movieDict["poster_path"] as? String {
            self._posterPath = posterPath
        }
        
    }
    
}
