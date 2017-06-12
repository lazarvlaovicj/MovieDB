//
//  FirstVC.swift
//  MovieDB
//
//  Created by PRO on 2/25/17.
//  Copyright © 2017 Lazar. All rights reserved.
//

import UIKit
import Alamofire

class FirstVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var inSearchMode = false
    
    var genresArr = [Genres]()
    var filteredArr = [Genres]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "The MovieDB"
        
        tableView.dataSource = self
        tableView.delegate = self
        
        searchBar.delegate = self
        
        searchBar.returnKeyType = UIReturnKeyType.done
        
        downloadGenres {}
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if inSearchMode{
            return filteredArr.count
        }
        
        return genresArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "GenresCell", for: indexPath) as? GenreCell {
            
            if inSearchMode{
                cell.cellConfig(genres: filteredArr[indexPath.row])
            }else {
                cell.cellConfig(genres: genresArr[indexPath.row])
            }
            return cell
            
        }
        
        return UITableViewCell()
    }
    
    func downloadGenres(complete: @escaping downloaded) {
        
        
        let GENRE_URL = "https://api.themoviedb.org/3/genre/movie/list?language=en-US&api_key=901c59b77a4ca64aa23d71c4788bc372"
        
        Alamofire.request(GENRE_URL).responseJSON{ response in
            
            let result = response.result
            
            switch result {
                
            case .success:
                if let dict = result.value as? Dictionary<String, AnyObject> {
                    if let genres = dict["genres"] as? [Dictionary<String, AnyObject>] {
                        
                        for obj in genres {
                            
                            let newObj = Genres(genreDict: obj)
                            self.genresArr.append(newObj)
                            
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
            filteredArr = genresArr.filter({ ($0.name.range(of: keyword, options: .caseInsensitive) != nil) })
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var genre: Genres!
        genre = genresArr[indexPath.row]
        performSegue(withIdentifier: "SecondVC", sender: genre.id)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? SecondVC {
            if let sender = sender as? String {
                dest.selected_URL = sender
            }
        }
    }
    
}

