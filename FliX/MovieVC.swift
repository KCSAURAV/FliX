//  MovieVC.swift
//  FliX
//
//  Created by SAURAV on 2/23/19.
//  Copyright © 2019 SAURAV. All rights reserved.

import UIKit
import AlamofireImage

class MovieVC: UIViewController,UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return movies.count; // row of 50 items
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
    
    //    cell.textLabel!.text = title;
    // ? also does Auto fix
    
    let movie = movies[indexPath.row]
    let title = movie["title"] as! String
    let synopsis = movie["overview"] as! String
    
    cell.name.text = title
    cell.synopsis.text = synopsis
    
    let base_url = "https://image.tmdb.org/t/p/w154";
    let poster_path = movie["poster_path"] as! String
    let pURL = URL(string: base_url + poster_path)
    cell.poster.af_setImage(withURL: pURL!)
    return cell
  }
  
  @IBOutlet weak var tableView: UITableView!
  
  var movies = [[String:Any]]() // these are properties..array of key:value
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    tableView.dataSource = self
    tableView.delegate = self
    let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
    let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
    let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
    let task = session.dataTask(with: request) { (data, response, error) in
      // This will run when the network request returns
      if let error = error {
        print(error.localizedDescription)
      } else if let data = data {
        let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
        
        // Get the array of movies & Store the movies in a property to use elsewhere
        self.movies = dataDictionary["results"] as! [[String:Any]];// casting
        
        self.tableView.reloadData();
        // TODO: Reload your table view data
//        print(dataDictionary)
        
      }
    }
    task.resume()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    // Find the movie
    let cell = sender as! UITableViewCell
    let indexPath = tableView.indexPath(for:cell)!
    let movie = movies[indexPath.row]
    // Pass the selected movie to Movie details VC
    let detailsVC = segue.destination as! MovieDetailsVC
    detailsVC.movie = movie
    
    tableView.deselectRow(at: indexPath, animated: true)  // removes highlight on tapped movie
  }
  
  override var prefersStatusBarHidden: Bool{
    return true
  }
}


