//
//  SecondVC.swift
//  MovieDB
//
//  Created by PRO on 2/26/17.
//  Copyright © 2017 Lazar. All rights reserved.
//

import UIKit
import Alamofire

class SecondVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var selected_URL: String = ""
    var moviesArr = [Movies]()
    var filteredArr = [Movies]()
    
    var inSearchMode = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Movies List"
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        searchBar.returnKeyType = UIReturnKeyType.done
        
        searchBar.delegate = self
        downloadMovieList {}
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if inSearchMode{
            return filteredArr.count
        }
        return moviesArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListCel", for: indexPath) as? MovieListCell{
            if inSearchMode{
                cell.configCell(movies: filteredArr[indexPath.row])
            }else{
                cell.configCell(movies: moviesArr[indexPath.row])
            }
            return cell
        }
        
        return UITableViewCell()
    }
    
    func downloadMovieList(complete: @escaping downloaded) {
        
        let movie_URL = "https://api.themoviedb.org/3/genre/\(selected_URL)/movies?api_key=901c59b77a4ca64aa23d71c4788bc372&language=en-US&include_adult=false&sort_by=created_at.asc"
        
        Alamofire.request(movie_URL).responseJSON { response in
            
            let result = response.result
            
            switch result {
                
            case .success:
                if let dict = result.value as? Dictionary<String, AnyObject> {
                    
                    if let results = dict["results"] as? [Dictionary<String, AnyObject>] {
                        
                        for object in results {
                            
                            let newObj = Movies(movieDict: object)
                            self.moviesArr.append(newObj)
                            
                        }
                        self.tableView.reloadData()
                    }
                }; complete()
                break
            case .failure:
                print("There was an error!")
                break
            }
            
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            inSearchMode = false
            tableView.reloadData()
            view.endEditing(true)
        }
        else{
            inSearchMode = true
            let keyword = searchBar.text!.lowercased()
            filteredArr = moviesArr.filter({ ($0.title.range(of: keyword) != nil) })
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var sender: Movies!
        sender = moviesArr[indexPath.row]
        performSegue(withIdentifier: "3rdVC", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? ThirdVC {
            if let sender = sender as? Movies {
                dest.movie = sender
            }
        }
    }
    
}









