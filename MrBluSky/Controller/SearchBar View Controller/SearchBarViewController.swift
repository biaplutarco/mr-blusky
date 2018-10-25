//
//  SearchBarViewController.swift
//  MrBluSky
//
//  Created by Bia Plutarco on 18/10/18.
//  Copyright © 2018 Bia Plutarco. All rights reserved.
//

import UIKit

class SearchBarViewController: UIViewController {
    // MARK: Instances
    let geocodinAPI = GeocodingAPIManager.sharedInstance
    
    // MARK: TableView
    var tableViewDataFiltered = [String]()
    
    // MARK: Constants
    var typeWeather: TypeWeather?
    var searchActive: Bool = true
    var searchNameCity = String()
    var newSearchText = String()
    
    // Make the Status Bar Light/Dark Content for this View
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
        //return UIStatusBarStyle.default   // Make dark again
    }
    
    // MARK: Delegate
    var delegate: SearchBarViewControllerDelegate?
    
    // MARK: APIData Stored
    var latitude = Double()
    var longitude = Double()
    var nameCity = String()
    
    // MARK: Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sunnyView: GradientView!
    @IBOutlet weak var nightView: GradientView!
    @IBOutlet weak var rainView: GradientView!
    
    // MARK: Life Circle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchBar.delegate = self
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.textColor = .white
        
        if searchActive == true {
            self.searchBar.becomeFirstResponder()
        }
        setBackgroundView()
    }
    
    // MARK: Methods
    func setBackgroundView() {
        if self.typeWeather == nil {
            typeWeather = .snow
        } else {
            DispatchQueue.main.async {
                switch self.typeWeather! {
                case .rain:
                    self.rainView.isHidden = false
                    self.sunnyView.isHidden = true
                    self.nightView.isHidden = true
                case .night:
                    self.nightView.isHidden = false
                    self.rainView.isHidden = true
                    self.sunnyView.isHidden = true
                case .sun:
                    self.sunnyView.isHidden = false
                    self.rainView.isHidden = true
                    self.nightView.isHidden = true
                default:
                    self.isAllDayHidden(bool: true)
                }
            }
        }
        
    }
    
    func isAllDayHidden(bool: Bool) { // Depois salvar a ultima cidade vista pelo user
        self.sunnyView.isHidden = bool
        self.nightView.isHidden = bool
        self.rainView.isHidden = bool
    }
    
    // MARK: Search Method and API Request
    func search(searchText: String? = nil){
        GeocodingAPIManager.sharedInstance.nameNewCity = searchText!
        GeocodingAPIManager.sharedInstance.getRequest(completion: { (response) in
            let cities = response.results
            print(cities)
            self.tableViewDataFiltered = []
            cities.forEach({ (result) in
                if result.components.type == "city" {
                    let cityCountry = result.components.country
                    let cityState = result.components.state
                    guard let cityName = result.components.city else { return }
                    let cityData = "\(cityName), \(cityState), \(cityCountry)"
                    
                    self.nameCity = cityName
                    self.latitude = result.geometry.lat
                    self.longitude = result.geometry.lng
                    
                    self.tableViewDataFiltered.append(cityData)
                } else if result.components.type == "state_district" {
                    let cityCountry = result.components.country
                    let cityState = result.components.state
                    let cityName = result.components.state
                    let cityData = "\(cityName), \(cityState), \(cityCountry)"
                    
                    self.nameCity = cityName
                    self.latitude = result.geometry.lat
                    self.longitude = result.geometry.lng
                    
                    self.tableViewDataFiltered.append(cityData)
                }
            })
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }, errorComp: {
            DispatchQueue.main.async {
                
                self.tableView.reloadData()
            }
        })
    }
}



    
    

