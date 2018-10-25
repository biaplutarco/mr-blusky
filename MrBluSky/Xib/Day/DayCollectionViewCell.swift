//
//  DayCollectionViewCell.swift
//  MrBluSky
//
//  Created by Bia Plutarco on 20/10/18.
//  Copyright © 2018 Bia Plutarco. All rights reserved.
//

import UIKit

class DayCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var weekDay: UILabel!
    @IBOutlet weak var tempHigh: UILabel!
    @IBOutlet weak var tempLow: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
