//
//  ShirtCollectionViewCell.swift
//  MrBluSky
//
//  Created by Bia Plutarco on 23/10/18.
//  Copyright © 2018 Bia Plutarco. All rights reserved.
//

import UIKit

class ShirtCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var shirtView: UIImageView!
    @IBOutlet weak var suitView: UIImageView!
    @IBOutlet weak var coatView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        shirtView.isHidden = false
        suitView.isHidden = true
        coatView.isHidden = true
        
    }

}
