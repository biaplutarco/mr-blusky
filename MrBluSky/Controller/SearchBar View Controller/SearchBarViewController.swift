//
//  SearchBarViewController.swift
//  MrBluSky
//
//  Created by Bia Plutarco on 18/10/18.
//  Copyright © 2018 Bia Plutarco. All rights reserved.
//

import UIKit

class SearchBarViewController: UIViewController {
    // MARK: TableView
    var tableViewDataFiltered = [String]()
    
    // MARK: Constants
    var cityID = [Int16]()
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
    var cityName = String()
    
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
}



    
    

