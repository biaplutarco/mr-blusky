//
//  ExtensionSearchBar.swift
//  MrBluSky
//
//  Created by Bia Plutarco on 21/10/18.
//  Copyright © 2018 Bia Plutarco. All rights reserved.
//

import UIKit

// MARK: - Extension SearchBarViewController 
extension SearchBarViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchActive = true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.searchActive = false
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchActive = false
        dismiss(animated: true, completion: nil)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchActive = false
        self.searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        Timer.scheduledTimer(withTimeInterval: TimeInterval(exactly: 1)!, repeats: false) { (timer) in
            ClimaTempoAPIManager.sharedInstance.getCityIDRequestBy(name: searchText, completion: { (responseObject) in
                if let cities = responseObject {
                    print(cities)
                    self.tableViewDataFiltered = []
                    cities.forEach({ (city) in
                        let citySearch = "\(city.name), \(city.state), \(city.country)"
                        self.tableViewDataFiltered.append(citySearch)
                        self.cityID.append(city.id)
                        self.cityName = city.name
        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                        
                    })
                    print(self.tableViewDataFiltered)
                }
            })
        }
    }
}


