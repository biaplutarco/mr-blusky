//
//  ExtensionMyDelegate.swift
//  MrBluSky
//
//  Created by Bia Plutarco on 21/10/18.
//  Copyright © 2018 Bia Plutarco. All rights reserved.
//

import UIKit

// MARK: - Extension ViewController 
extension ViewController: SearchBarViewControllerDelegate {
    func addNewCity(name: String, id: Int16) {
        DBManager.sharedInstance.saveCity(name: name, id: id)
        self.cityCollectionData.append(name)
        self.cityCollectionView.reloadData()
        isDayHidden(bool: true)
    }
    
    func didAddedNewCity(_ bool: Bool) {
        isCityAdded = bool
        isDayHidden(bool: true)
        let cityID = dbManager.getCityID(name: cityCollectionData.last!)
        getCurrentData(cityID: cityID)
        getForecastData(cityID: cityID, row: (self.cityCollectionData.count-1), indexPath: nil)
    }
}
