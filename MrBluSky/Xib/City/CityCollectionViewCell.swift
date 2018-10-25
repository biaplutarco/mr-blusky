//
//  CityCollectionViewCell.swift
//  MrBluSky
//
//  Created by Bia Plutarco on 19/10/18.
//  Copyright © 2018 Bia Plutarco. All rights reserved.
//

import UIKit

class CityCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var deleteItemIcon: UIImageView!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var barSeletedView: UIView!
    @IBOutlet weak var isSeletedBar: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override var isSelected: Bool {
        didSet{
            if self.isSelected {
                self.cityName.backgroundColor = #colorLiteral(red: 0.9999018312, green: 1, blue: 0.9998798966, alpha: 0.2471372003)
                self.cityName.textColor = .white
                self.cityName.font = UIFont.systemFont(ofSize: 14, weight: .bold)
                self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                
            } else {
                self.cityName.backgroundColor = .clear
                self.cityName.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
                self.transform = CGAffineTransform.identity
                self.cityName.textColor = #colorLiteral(red: 0.9999018312, green: 1, blue: 0.9998798966, alpha: 0.7542273116)
            }
        }
    }
    
    
}
