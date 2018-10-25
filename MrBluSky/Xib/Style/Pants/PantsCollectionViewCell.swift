//
//  PantsCollectionViewCell.swift
//  MrBluSky
//
//  Created by Bia Plutarco on 23/10/18.
//  Copyright © 2018 Bia Plutarco. All rights reserved.
//

import UIKit

class PantsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var pantsView: UIImageView!
    @IBOutlet weak var shortsView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        pantsView.isHidden = false
        shortsView.isHidden = true
    }

}
