//
//  WeatherCollectionViewCell.swift
//  MrBluSky
//
//  Created by Bia Plutarco on 23/10/18.
//  Copyright © 2018 Bia Plutarco. All rights reserved.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override var isSelected: Bool {
        didSet{
            if self.isSelected {
                self.imageView.backgroundColor = #colorLiteral(red: 0.9999018312, green: 1, blue: 0.9998798966, alpha: 0.2471372003)
                self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                
            } else {
                self.imageView.backgroundColor = .clear
                self.transform = CGAffineTransform.identity
            }
        }
    }
}
