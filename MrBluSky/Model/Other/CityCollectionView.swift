//
//  CityCollectionView.swift
//  MrBluSky
//
//  Created by Bia Plutarco on 22/10/18.
//  Copyright © 2018 Bia Plutarco. All rights reserved.
//

import UIKit

class CityCollectionView: UICollectionView {
    func didSelectedCityItem(indexPath: IndexPath) {
        if self.visibleCells.first?.isSelected == true {
            self.cellForItem(at: indexPath)!.isSelected = false
        }
        if self.cellForItem(at: indexPath)!.isSelected == true {
            self.cellForItem(at: indexPath)?.isSelected = false
        }
        
        self.selectItem(at: indexPath, animated: true, scrollPosition: .bottom)
    }
}
