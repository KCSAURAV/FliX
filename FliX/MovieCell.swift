//
//  MovieCell.swift
//  FliX
//
//  Created by SAURAV on 2/23/19.
//  Copyright © 2019 SAURAV. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {

  @IBOutlet weak var name: UILabel!
  @IBOutlet weak var synopsis: UILabel!
  @IBOutlet weak var poster: UIImageView!
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
