//
//  ThirdVC.swift
//  MovieDB
//
//  Created by PRO on 2/27/17.
//  Copyright © 2017 Lazar. All rights reserved.
//

import UIKit
import Alamofire

class ThirdVC: UIViewController {
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var movieImg: UIImageView!
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var webTrailerVideo: UIWebView!
    @IBOutlet weak var textDesc: UITextView!
    
    var movie: Movies!
    var key = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Movie"
        
        getTrailerID {self.updateUI()}
    
    }
    
    func updateUI() {
        print(movie.id)
        self.movieName.text = movie.title
        self.ratingLbl.text = movie.voteAverage
        self.textDesc.text = movie.overview
        
        let img = URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath)")
        
        DispatchQueue.global().async {
            do{
                let data = try Data(contentsOf: img!)
                DispatchQueue.main.sync {
                    self.movieImg.image = UIImage(data: data)
                }
            }catch{
                print(error.localizedDescription)
            }
        }
//        let url = "https://www.youtube.com/watch?v=\(key)"
//        //let url = URL(fileURLWithPath: url1)
//        webTrailerVideo.loadHTMLString(url, baseURL: nil)
        
        let url = NSURL(string: "https://www.youtube.com/watch?v=\(key)")!
        webTrailerVideo.loadRequest(NSURLRequest(url: url as URL) as URLRequest)
    }
    
    func getTrailerID(complete: @escaping downloaded) {
        
        let url = "https://api.themoviedb.org/3/movie/\(movie.id)/videos?api_key=901c59b77a4ca64aa23d71c4788bc372&language=en-US"
        
        
        Alamofire.request(url).responseJSON { response in
        
            let result = response.result
            
            switch result {
            case .success:
                if let dict = result.value as? Dictionary<String, AnyObject> {
                    
                    if let result = dict["results"] as? [Dictionary<String, AnyObject>] {
                        if let key = result[0]["key"] as? String {
                            self.key = key
                        }
                    }
                }; complete()
                break
            case .failure:
                    print("There was an error!")
                break
            }
            
        }
    
    }






}
