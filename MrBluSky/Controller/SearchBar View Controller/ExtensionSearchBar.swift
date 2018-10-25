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
        self.searchBar.placeholder = "aaaa"
        search(searchText: newSearchText)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.newSearchText = searchText.replacingOccurrences(of: " ", with: "%20", options: .regularExpression, range: nil)
    }
}


