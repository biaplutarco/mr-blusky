//
//  ViewController.swift
//  MrBluSky
//
//  Created by Bia Plutarco on 16/10/18.
//  Copyright © 2018 Bia Plutarco. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    // MARK: Instances
    let dbManager = DBManager.sharedInstance
    
    // MARK: CollectionView
    var showsDayCollection: Bool = false
    var dayCollectionData = [Day]()
    var cityCollectionData = [String]()
    var cityCollectionCanEditing = false
    var isCityAdded: Bool = false
    
    // MARK: Constants
    var deleteCityName = [String]()
    var images = [String]()
    var imagesContents = Data()
    var cityLatitude = Double()
    var cityLongitude = Double()
    var typeWeather: TypeWeather?
    let dynamicColor = DynamicColor()
    var bigWord: Bool = false
    
    // Make the Status Bar Light/Dark Content for this View
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
        //return UIStatusBarStyle.default   // Make dark again
    }
    
    // MARK: Outlets
    @IBOutlet weak var styleImage: UIImageView!
    @IBOutlet weak var dayCollectionView: DayCollectionView!
    @IBOutlet weak var cityCollectionView: CityCollectionView!
    @IBOutlet weak var bigTempToday: UILabel!
    @IBOutlet weak var humidity: UILabel!
    @IBOutlet weak var precipProbability: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var addAndCancelButton: UIButton!
    @IBOutlet weak var sunnyView: GradientView!
    @IBOutlet weak var nightView: GradientView!
    @IBOutlet weak var rainView: GradientView!
    @IBOutlet weak var weatherCurrentlyIcon: UIImageView!
    @IBOutlet weak var humidityIcon: UIImageView!
    @IBOutlet weak var precipProbIcon: UIImageView!
    @IBOutlet weak var chanceLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    // MARK: Actions
    @IBAction func addNewCity(_ sender: Any) {
        if cityCollectionCanEditing == false {
            performSegue(withIdentifier: "addCity", sender: nil)
            
        } else {
            cancelDeleteCity()
        }
    }
    
    @IBAction func deleteCity(_ sender: Any) {
        if editButton.titleLabel!.text == "Editar" {
            //self.cityCollectionView.visibleCells.first!.isSelected = true
            editingCity()
        } else {
            
                deleteCityName.forEach { (city) in
                    self.deleteCity(editButton: self.editButton, addButton: self.addAndCancelButton, deleteCityName: city)
                
            }
            settingsDeleteCity()
        }
    }
    // MARK: Life Circle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isDayHidden(bool: true)
        
        if self.typeWeather ==  nil {
            setGradientViewAndIconWeather(dynamicColor.setFisrtColor())
        }
        
        self.cityCollectionView.delegate = self
        self.cityCollectionView.dataSource = self
        self.dayCollectionView.delegate = self
        self.dayCollectionView.dataSource = self
        
        self.cityCollectionData = dbManager.getCityNames()
        self.cityCollectionView.reloadData()
        self.cityCollectionView.register(UINib(nibName: "CityCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cellCity")
        self.dayCollectionView.register(UINib(nibName: "DayCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cellDay")
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tappedImage(sender:)))
        styleImage.isUserInteractionEnabled = true
        styleImage.addGestureRecognizer(tapGestureRecognizer)
    
    }
    
    @objc func tappedImage(sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "styleSegue", sender: styleImage)
    }
    
    // MARK: - Action Methods
    func deleteCity(editButton: UIButton, addButton: UIButton, deleteCityName: String) {
        editButton.setTitle("Editar", for: .normal)
        DBManager.sharedInstance.deleteCity(name: deleteCityName)
        addButton.setImage(#imageLiteral(resourceName: "add"), for: .normal)
        addButton.setTitle("", for: .normal)
    }
    
    func settingsDeleteCity() {
        isDayHidden(bool: true)
        
        self.cityCollectionData = dbManager.getCityNames()
        deleteCityName.forEach { (city) in
            if cityCollectionData.contains(city) {
                cityCollectionData.removeAll { (cityName) -> Bool in
                    cityName == city
                }
            }
        }
        
        self.cityCollectionView.reloadData()
        dayCollectionData.removeAll()
        self.dayCollectionView.reloadData()
        cityCollectionCanEditing = false
    }
    
    func editingCity() {
        cityCollectionView.reloadData()
        editButton.setTitle("Deletar", for: .normal)
        cityCollectionCanEditing = true
        addAndCancelButton.setImage(UIImage(), for: .normal)
        addAndCancelButton.setTitle("Cancelar", for: .normal)
        isDayHidden(bool: true)
//        isBallonHidden(bool: false)
    }
    
    func cancelDeleteCity() {
        editButton.setTitle("Editar", for: .normal)
        addAndCancelButton.setImage(#imageLiteral(resourceName: "add"), for: .normal)
        addAndCancelButton.setTitle("", for: .normal)
        cityCollectionCanEditing = false
        cityCollectionView.reloadData()
    }
    
    // MARK: - isHidden and shows
    func isDayHidden(bool: Bool) { // Depois salvar a ultima cidade vista pelo user
        DispatchQueue.main.async {
            self.dayCollectionView.isHidden = bool
            self.bigTempToday.isHidden = bool
            self.humidity.isHidden = bool
            self.precipProbability.isHidden = bool
            self.weatherCurrentlyIcon.isHidden = bool
            self.humidityIcon.isHidden = bool
            self.precipProbIcon.isHidden = bool
            self.chanceLabel.isHidden = bool
            self.humidityLabel.isHidden = bool
        }
    }
    
    func isBackgroundHidden(bool: Bool) {
        self.sunnyView.isHidden = bool
        self.nightView.isHidden = bool
        self.rainView.isHidden = bool
    }
//
//    func isBallonHidden(bool: Bool){
//        self.ballon.isHidden = bool
//        self.textOne.isHidden = bool
//        self.textTwo.isHidden = bool
//    }
    
    func isForWeatherTypeHidden (_ weatherType: String, rainView: Bool, sunnyView: Bool, nightView: Bool) {
        self.weatherCurrentlyIcon.image = UIImage.init(named: weatherType)
        self.rainView.isHidden = rainView
        self.sunnyView.isHidden = sunnyView
        self.nightView.isHidden = nightView
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addCity" {
            let destination = segue.destination as! SearchBarViewController
            destination.delegate = self
            destination.typeWeather = self.typeWeather
        } else {
            let destination = segue.destination as! ChooseStyleViewController
            destination.typeWeather = self.typeWeather
        }
        
    }
    
    
    // MARK: - Set Outlets View Controller
    func setDataOutlets(tempToday: String, humidity: String, precipProb: String) {
        DispatchQueue.main.async {
            self.bigTempToday.text = tempToday
            self.humidity.text = humidity
            self.precipProbability.text = precipProb
        }
    }
    
    func setGradientViewAndIconWeather(_ iconText: String) {
        self.typeWeather = dynamicColor.getColor(iconText: iconText)
            DispatchQueue.main.async {
                switch self.typeWeather! {
                case .rain:
                    self.isForWeatherTypeHidden("cloudy", rainView: false, sunnyView: true, nightView: true)
                case .night:
                    self.isForWeatherTypeHidden("night", rainView: true, sunnyView: true, nightView: false)
                case .sun:
                    self.isForWeatherTypeHidden("sun", rainView: true, sunnyView: false, nightView: true)
                default:
                    self.isDayHidden (bool: true)
                }
            }
    }
    
    func showDayCollectionData(forecast: Forecast) {
        self.dayCollectionData.removeAll()
        self.dayCollectionData = self.dayCollectionView.setCollectionData(forecast: forecast)
        self.showsDayCollection = true
    }
    
    func getCurrentData(cityID: Int16) {
        ClimaTempoAPIManager.sharedInstance.getCityCurrentWeather(id: cityID) { (currentWeather) in
            let data = currentWeather?.data
            self.setGradientViewAndIconWeather(data!.condition)
            
            let currentTemp = "\(data!.temperatureInt)°"
            let cityName = currentWeather?.name
            
            UserDefaults.standard.removeObject(forKey: "group.com.biaplutarco.mrblusky")
            
            UserDefaults.init(suiteName: "group.com.biaplutarco.mrblusky")?.setValue(currentTemp, forKey: "currentTemp")
            UserDefaults.init(suiteName: "group.com.biaplutarco.mrblusky")?.setValue(cityName, forKey: "cityName")
            
            DispatchQueue.main.async {
                self.bigTempToday.text = "\(data!.temperatureInt)°"
                self.humidity.text = "\(data!.humidityInt)%"
                self.dayCollectionView.reloadData()
            }
        }
    }
    
    func getForecastData(cityID: Int16, row: Int?, indexPath: IndexPath?) {
        ClimaTempoAPIManager.sharedInstance.getCityForecast(id: cityID) { (forecast) in
            DispatchQueue.main.async {
                self.dayCollectionData.removeAll()
                self.dayCollectionData = self.dayCollectionView.setCollectionData(forecast: forecast!)
                self.showsDayCollection = true
                self.dayCollectionView.reloadData()
            }
            
            DispatchQueue.main.async {
                self.isDayHidden(bool: false)
                self.cityCollectionView.reloadData()
                self.dayCollectionView.reloadData()
                //TEM QUE FAZER A CELL FICAR SELETED
                DispatchQueue.main.async {
                    if row != nil {
                        let myIndexPath = IndexPath(item: row!, section: 0)
                        self.cityCollectionView.scrollToItem(at: myIndexPath, at: .centeredHorizontally, animated: true)
                        self.cityCollectionView.cellForItem(at: myIndexPath)?.isSelected = true
                        
                        let tempHigh = self.dayCollectionData[row!].tempHigh
                        let tempLow = self.dayCollectionData[row!].tempLow
                        let text = forecast?.data[row!].textIcon.text.pt
                        
                        UserDefaults.standard.removeObject(forKey: "group.com.biaplutarco.mrblusky")
                        
                        UserDefaults.init(suiteName: "group.com.biaplutarco.mrblusky")?.setValue(text, forKey: "text")
                        UserDefaults.init(suiteName: "group.com.biaplutarco.mrblusky")?.setValue(tempHigh, forKey: "tempHigh")
                        UserDefaults.init(suiteName: "group.com.biaplutarco.mrblusky")?.setValue(tempLow, forKey: "tempLow")
                    }
                    if indexPath != nil {
                        self.cityCollectionView.scrollToItem(at: indexPath!, at: .centeredHorizontally, animated: true)
                        self.cityCollectionView.cellForItem(at: indexPath!)?.isSelected = true
                        
                        let tempHigh = self.dayCollectionData[indexPath!.row].tempHigh
                        let tempLow = self.dayCollectionData[indexPath!.row].tempLow
                        let text = forecast?.data[indexPath!.row].textIcon.text.pt
                        
                        UserDefaults.standard.removeObject(forKey: "group.com.biaplutarco.mrblusky")
                        
                        UserDefaults.init(suiteName: "group.com.biaplutarco.mrblusky")?.setValue(text, forKey: "text")
                        UserDefaults.init(suiteName: "group.com.biaplutarco.mrblusky")?.setValue(tempHigh, forKey: "tempHigh")
                        UserDefaults.init(suiteName: "group.com.biaplutarco.mrblusky")?.setValue(tempLow, forKey: "tempLow")
                    }
                    
                }
            }
        }
    }
    
}

