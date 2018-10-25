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
    func didAddedNewCity(_ bool: Bool) {
        isCityAdded = bool
        isDayHidden(bool: true)
        
        let coordination = dbManager.getCityCoordination(name: cityCollectionData.last!)
        weatherAPI.currentLatidude = coordination.0
        weatherAPI.currentLongitude = coordination.1
        weatherAPI.getRequest { (response) in
            let currently = response.currently
            self.setDataOutlets(tempToday: "\(currently.temperatureCelsius)°", humidity: "\(currently.humidityPercent)%", precipProb: "\(currently.precipProbabilityPercent)%")
            self.setGradientViewAndIconWeather(currently.icon)
            self.dayCollectionData.removeAll()
            self.dayCollectionData = self.dayCollectionView.setCollectionData(response: response)
            self.showsDayCollection = true
            DispatchQueue.main.async {
                self.dayCollectionView.reloadData()
                self.isDayHidden(bool: false)
                self.cityCollectionView.reloadData()
                //TEM QUE FAZER A CELL FICAR SELETED
                DispatchQueue.main.async {
                    
                    
                    let indexPath = IndexPath(item: (self.cityCollectionData.count-1), section: 0)
//                    (self.cityCollectionView.cellForItem(at: indexPath) as! CityCollectionViewCell).isSelected = true
                    self.cityCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
                    self.cityCollectionView.cellForItem(at: indexPath)?.isSelected = true

                }
            }
        }
    }
    
    func addNewCity(latitude: Double, longitude: Double, name: String) {
        dbManager.saveCity(latitude: latitude, longitude: longitude, name: name)
        self.cityLatitude = latitude
        self.cityLongitude = longitude
        self.cityCollectionData.append(name)
        self.cityCollectionView.reloadData()
        isDayHidden(bool: true)
    }
    
}
