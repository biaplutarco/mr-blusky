//
//  CollectionViewExtension.swift
//  MrBluSky
//
//  Created by Bia Plutarco on 21/10/18.
//  Copyright © 2018 Bia Plutarco. All rights reserved.
//

import UIKit

// MARK: - Extension ViewController
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 1 && showsDayCollection == true {
            return dayCollectionData.count - 1 //pq a api me dar 8 dias
        } else {
            return cityCollectionData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellDay", for: indexPath) as? DayCollectionViewCell else { return  UICollectionViewCell() }
            if showsDayCollection == true {
                cell.weekDay.text = dayCollectionData[indexPath.row].nameDay.uppercased()
                cell.tempHigh.text = dayCollectionData[indexPath.row].tempHigh
                cell.tempLow.text = dayCollectionData[indexPath.row].tempLow

                return cell
            } else {
                return cell
            }
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellCity", for: indexPath) as? CityCollectionViewCell else { return UICollectionViewCell() }
            cell.cityName.text = self.cityCollectionData[indexPath.row].uppercased()
            cell.isSelected = false
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 0 {
            if cityCollectionCanEditing == false {
                let activityIndicator = UIActivityIndicatorView(style: .white)
                
                isDayHidden(bool: true)
                cityCollectionView.allowsMultipleSelection = false
                
                let index = IndexPath(row: cityCollectionData.count-1, section: 0)
                if collectionView.cellForItem(at: index)?.isSelected == true {
                    collectionView.cellForItem(at: index)?.isSelected = false
                }
                collectionView.cellForItem(at: indexPath)?.isSelected = true
                isDayHidden(bool: false)
                
                let cityID = dbManager.getCityID(name: cityCollectionData[indexPath.row])
                getCurrentData(cityID: cityID)
                getForecastData(cityID: cityID, row: nil, indexPath: indexPath)
            } else {
                cityCollectionView.allowsMultipleSelection = true
                cityCollectionView.cellForItem(at: indexPath)?.transform = CGAffineTransform.identity
                
                var rows = [Int]()
                cityCollectionView.didSelectedCityItem(indexPath: indexPath)
                rows.append(indexPath.row)
                
                rows.forEach { (row) in
                    deleteCityName.append(cityCollectionData[row]) 
                }
                
            }
            self.cityCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 0 {
            if cityCollectionData[indexPath.row].uppercased().count > 6 {
                if cityCollectionData[indexPath.row].uppercased().count > 9 {
                    return CGSize(width: 140, height: 38)
                } else {
                    return CGSize(width: 110, height: 38)
                }
            } else {
                return CGSize(width: 80, height: 38)
            }
        } else {
            return CGSize(width: 36, height: 140)
        }
    }
}
