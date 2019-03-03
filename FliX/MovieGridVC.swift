//
//  MovieGridVC.swift
//  FliX
//
//  Created by SAURAV on 3/2/19.
//  Copyright © 2019 SAURAV. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieGridVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
  

  @IBOutlet weak var collectionView: UICollectionView!
  var movies = [[String:Any]]()
    override func viewDidLoad() {
        super.viewDidLoad()
      collectionView.delegate = self
      collectionView.dataSource = self
      
      // Layout /optional
      
      let layout = collectionView.collectionViewLayout as!
        UICollectionViewFlowLayout
      
      layout.minimumLineSpacing = 4
      layout.minimumInteritemSpacing = 4
      
      let width = (view.frame.size.width - layout.minimumInteritemSpacing * 2) / 3
      
      layout.itemSize = CGSize(width: width, height: width * 3 / 2)
      
      
        // Do any additional setup after loading the view.
      let url = URL(string: "https://api.themoviedb.org/3/movie/297762/similar?api_key=dcc18672beb28dd5960858c5c3e3b174")! // "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")
      let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
      let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
      let task = session.dataTask(with: request) { (data, response, error) in
        // This will run when the network request returns
        if let error = error {
          print(error.localizedDescription)
        } else if let data = data {
          let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
          self.movies = dataDictionary["results"] as! [[String:Any]]
          // print( self.movies )
          self.collectionView.reloadData()
        }
      }
      task.resume()
    }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return movies.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieGridCell", for: indexPath) as! MovieGridCell
    let base_url = "https://image.tmdb.org/t/p/w154";
    
    let movie = movies[indexPath.item]
    let poster = movie["poster_path"] as! String
    let pURL = URL(string: base_url + poster)
    cell.poster.af_setImage(withURL: pURL!)
    
    return cell
  }
  
  override var prefersStatusBarHidden: Bool{
    return true
  }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
