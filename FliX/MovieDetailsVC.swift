//
//  MovieDetailsVC.swift
//  FliX
//
//  Created by SAURAV on 3/2/19.
//  Copyright © 2019 SAURAV. All rights reserved.
//

import UIKit
import AlamofireImage
class MovieDetailsVC: UIViewController {

  @IBOutlet weak var poster: UIImageView!
  @IBOutlet weak var backDrop: UIImageView!
  var movie: [String:Any]!
  @IBOutlet weak var titleL: UILabel!
  @IBOutlet weak var synopsisL: UILabel!
  
  override func viewDidLoad() {
      super.viewDidLoad()
    
     navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
       navigationController?.navigationBar.shadowImage = UIImage()
    
    navigationController?.navigationBar.tintColor = UIColor.green
    //    UIApplication.shared.statusBarStyle = .lightContent
    
    titleL.text = movie["title"] as? String
    titleL.sizeToFit()
    synopsisL.text = movie["overview"] as? String
    synopsisL.sizeToFit()
    let base_url = "https://image.tmdb.org/t/p/w154";
    let poster_path = movie["poster_path"] as! String
    let pURL = URL(string: base_url + poster_path)
    poster.af_setImage(withURL: pURL!)
      // Do any additional setup after loading the view.
    
    let backDrop_path = movie["backdrop_path"] as! String
    let backDropURL = URL(string: "https://image.tmdb.org/t/p/w780" + backDrop_path)
    backDrop.af_setImage(withURL: backDropURL!)
  }

  // MARK: - Navigation

  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      // Get the new view controller using segue.destination.
      // Pass the selected object to the new view controller.
    
  }
  
  override var prefersStatusBarHidden: Bool{
    return true
  }
}
