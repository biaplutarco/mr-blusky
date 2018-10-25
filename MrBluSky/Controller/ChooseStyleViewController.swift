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
    
    @IBOutlet weak var rainView: GradientView!
    @IBOutlet weak var nightView: GradientView!
    @IBOutlet weak var sunnyView: GradientView!
    @IBOutlet weak var weatherCollectionView: UICollectionView!
    @IBOutlet weak var shirtCollectionView: UICollectionView!
    @IBOutlet weak var pantsCollectionView: UICollectionView!
    
    @IBAction func saveNewStyle(_ sender: Any) {
//        let newStyleImage = saveNewStyle(
//                     head: (headCollectionView.visibleCells.first as!HeadCollectionViewCell).imageView.image!,
//                     shirt: (shirtCollectionView.visibleCells.first as! ShirtCollectionViewCell).imageView.image!,
//                     pants: (pantsCollectionView.visibleCells.first as! PantsCollectionViewCell).imageView.image!)
//        DBManager.sharedInstance.saveSunStyle(path: "teste", image: newStyleImage)
//        teste.image = DBManager.sharedInstance.getSunStyle()
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
    
    func saveNewStyle(head: UIImage, shirt: UIImage, pants: UIImage) -> UIImage{
        let size = CGSize(width: 138, height: 200)
        UIGraphicsBeginImageContext(size)
        
        let areaSize = CGRect(x: 0, y: 0, width: size.width, height: size.height/2)
        shirt.draw(in: areaSize)
        let areaSize2 = CGRect(x: 0, y: 100, width: size.width, height: size.height/2)
        pants.draw(in: areaSize2)
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        UIGraphicsEndImageContext()
        
        return newImage
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

