//
//  ChooseStyleViewController.swift
//  MrBluSky
//
//  Created by Bia Plutarco on 23/10/18.
//  Copyright © 2018 Bia Plutarco. All rights reserved.
//

import UIKit

class ChooseStyleViewController: UIViewController {
    
    let weatherCollectionData: [UIImage] = [#imageLiteral(resourceName: "rain"), #imageLiteral(resourceName: "sun"), #imageLiteral(resourceName: "moon")]
    let shirtCollectionData: [UIImage] = [#imageLiteral(resourceName: "t-shirt"), #imageLiteral(resourceName: "suit"), #imageLiteral(resourceName: "coat")]
    let pantsCollectionData: [UIImage] = [#imageLiteral(resourceName: "pants"),#imageLiteral(resourceName: "shorts")]
    
    
    var typeWeather: TypeWeather?
    var weatherChoosen: UIImage?
    var shirtChoosen: UIImage?
    var pantsChoosen: UIImage?
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
        //return UIStatusBarStyle.default   // Make dark again
    }
    
    @IBOutlet weak var teste: UIImageView!
    @IBOutlet weak var rainView: GradientView!
    @IBOutlet weak var nightView: GradientView!
    @IBOutlet weak var sunnyView: GradientView!
    @IBOutlet weak var weatherCollectionView: UICollectionView!
    @IBOutlet weak var shirtCollectionView: UICollectionView!
    @IBOutlet weak var pantsCollectionView: UICollectionView!
    
    @IBAction func saveNewStyle(_ sender: Any) {
        saveNewStyle()
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isWeatherViewHidden(type: typeWeather!, bool: false)
        
        
        weatherCollectionView.delegate = self
        shirtCollectionView.delegate = self
        pantsCollectionView.delegate = self
        
        weatherCollectionView.dataSource = self
        shirtCollectionView.dataSource = self
        pantsCollectionView.dataSource = self
        
        weatherCollectionView.register(UINib(nibName: "WeatherCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "weatherCell")
        shirtCollectionView.register(UINib(nibName: "ShirtCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "shirtCell")
        pantsCollectionView.register(UINib(nibName: "PantsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "pantsCell")
    }
    
    func getNewStyle(shirt: UIImage, pants: UIImage) -> UIImage{
        let coatView = (shirtCollectionView.visibleCells.first as! ShirtCollectionViewCell).coatView
        let shirtView = (shirtCollectionView.visibleCells.first as! ShirtCollectionViewCell).shirtView
        let pantsView = (pantsCollectionView.visibleCells.first as! PantsCollectionViewCell).pantsView
        let headImage = #imageLiteral(resourceName: "head")
        let headSize = CGSize(width: 60, height: 63)
        
        
        var shirtSize = CGSize()
        var pantsSize = CGSize()
        var pantsY = CGFloat()
        var pantsX = CGFloat()
        var headX = CGFloat()
        
        if shirt == shirtView?.image {
            shirtSize = CGSize(width: 162, height: 140)
            pantsY = 8
            headX = 35
            
            if pants == pantsView?.image {
                pantsSize = CGSize(width: 108, height: 230)
                pantsX = 0
            } else {
                pantsSize = CGSize(width: 81, height: 230)
                pantsX = 30
            }
            
        } else if shirt == coatView?.image {
            shirtSize = CGSize(width: 144, height: 180)
            pantsY = 50
            headX = 30
            
            if pants == pantsView?.image {
                pantsSize = CGSize(width: 108, height: 230)
                pantsX = 10
            } else {
                pantsSize = CGSize(width: 81, height: 230)
                pantsX = 30
            }
            
        } else {
            shirtSize = CGSize(width: 180, height: 160)
            pantsY = 35
            headX = 60
            
            if pants == pantsView?.image {
                pantsSize = CGSize(width: 108, height: 230)
                pantsX = 35
            } else {
                pantsSize = CGSize(width: 81, height: 230)
                pantsX = 60
            }
        }
        
        
        
        let size = CGSize(width: 180, height: 473)
        
        UIGraphicsBeginImageContext(size)
        
        let areaPants = CGRect(x: pantsX, y: (shirtSize.height + headSize.height) - pantsY, width: pantsSize.width, height: pantsSize.height)
        pants.draw(in: areaPants)
        
        let areaShirt = CGRect(x: 0, y: headSize.height, width: shirtSize.width, height: shirtSize.height)
        shirt.draw(in: areaShirt)
        
        let areaHead = CGRect(x: headX, y: 10, width: headSize.width, height: headSize.height)
        headImage.draw(in: areaHead)
        
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func saveNewStyle() {
        var shirtImage = UIImage()
        var pantsImage = UIImage()
        
        let visibleShirtCell = shirtCollectionView.visibleCells.first
        let firstShirtCell = shirtCollectionView.cellForItem(at: IndexPath(row: 0, section: 0))
        let secondShirtCell = shirtCollectionView.cellForItem(at: IndexPath(row: 1, section: 0))
        
        let visiblePantsCell = pantsCollectionView.visibleCells.first
        let firstPantsCell = pantsCollectionView.cellForItem(at: IndexPath(row: 0, section: 0))
        
        if visibleShirtCell == firstShirtCell {
            shirtImage = ((shirtCollectionView.visibleCells.first as? ShirtCollectionViewCell)?.shirtView.image)!
        } else if visibleShirtCell == secondShirtCell {
            shirtImage = ((shirtCollectionView.visibleCells.first as? ShirtCollectionViewCell)?.suitView.image)!
        } else {
            shirtImage = ((shirtCollectionView.visibleCells.first as? ShirtCollectionViewCell)?.coatView.image)!
        }
        
        if visiblePantsCell == firstPantsCell {
            pantsImage = ((pantsCollectionView.visibleCells.first as? PantsCollectionViewCell)?.pantsView.image)!
        } else {
            pantsImage = ((pantsCollectionView.visibleCells.first as? PantsCollectionViewCell)?.shortsView.image)!
        }
        
        let newStyleImage = getNewStyle(shirt: shirtImage, pants: pantsImage)
        //        DBManager.sharedInstance.saveSunStyle(path: "teste", image: newStyleImage)
        teste.image = newStyleImage
    }
    
    func isWeatherViewHidden(type: TypeWeather, bool: Bool) {
        switch type {
        case .sun:
            if bool == false {
                rainView.isHidden = true
                nightView.isHidden = true
                sunnyView.isHidden = bool
            }
        case .night:
            if bool == false {
                sunnyView.isHidden = true
                rainView.isHidden = true
                nightView.isHidden = bool
            }
        default:
            if bool == false {
                sunnyView.isHidden = true
                nightView.isHidden = true
                rainView.isHidden = bool
            }
        }
        
    }
    
}

extension ChooseStyleViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 0 {
            return weatherCollectionData.count
        } else if collectionView.tag == 1 {
            return shirtCollectionData.count
        } else {
            return pantsCollectionData.count
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weatherCell", for: indexPath) as? WeatherCollectionViewCell else { return UICollectionViewCell() }
            cell.imageView.image = weatherCollectionData[indexPath.row]
            return cell
        } else if collectionView.tag == 1 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "shirtCell", for: indexPath) as? ShirtCollectionViewCell else { return UICollectionViewCell() }
            if indexPath.row == 0 {
                cell.shirtView.image = shirtCollectionData[indexPath.row]
            } else if indexPath.row == 1 {
                cell.shirtView.isHidden = true
                cell.suitView.isHidden = false
                cell.suitView.image = shirtCollectionData[indexPath.row]
            } else {
                cell.suitView.isHidden = true
                cell.coatView.isHidden = false
                cell.coatView.image = shirtCollectionData[indexPath.row]
            }
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pantsCell", for: indexPath) as? PantsCollectionViewCell else { return UICollectionViewCell() }
            if indexPath.row == 0 {
                cell.pantsView.image = pantsCollectionData[indexPath.row]
            } else {
                cell.pantsView.isHidden = true
                cell.shortsView.isHidden = false
                cell.shortsView.image = pantsCollectionData[indexPath.row]
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 0 {
            return CGSize(width: collectionView.frame.width/3, height: collectionView.frame.height)
        } else {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 0 {
            if indexPath.row == 0 {
                (collectionView.cellForItem(at: indexPath) as! WeatherCollectionViewCell).isSelected = true
                isWeatherViewHidden(type: .rain, bool: false)
            } else if indexPath.row == 1 {
                collectionView.cellForItem(at: indexPath)?.isSelected = true
                isWeatherViewHidden(type: .sun, bool: false)
            } else {
                collectionView.cellForItem(at: indexPath)?.isSelected = true
                isWeatherViewHidden(type: .night, bool: false)
            }
        }
        
        
    }
}

