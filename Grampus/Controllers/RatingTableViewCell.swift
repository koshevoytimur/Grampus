//
//  RatingTableViewCell.swift
//  Grampus
//
//  Created by Тимур Кошевой on 5/22/19.
//  Copyright © 2019 Тимур Кошевой. All rights reserved.
//

import UIKit

class RatingTableViewCell: UITableViewCell {

    @IBOutlet weak var _imageViewCell: UIImageView!
    @IBOutlet weak var _nameLabelCell: UILabel!
    @IBOutlet weak var _professionLabelCell: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        _imageViewCell.layer.cornerRadius = 40
        _imageViewCell.layer.borderWidth = 1.5
        _imageViewCell.layer.borderColor = UIColor.darkGray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
