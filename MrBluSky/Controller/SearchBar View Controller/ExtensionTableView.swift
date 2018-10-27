//
//  ExtensionTableView.swift
//  MrBluSky
//
//  Created by Bia Plutarco on 21/10/18.
//  Copyright © 2018 Bia Plutarco. All rights reserved.
//

import UIKit

// MARK: - Extension SearchBarViewController
extension SearchBarViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableViewDataFiltered.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell!.textLabel?.text = tableViewDataFiltered[indexPath.row]
        cell!.textLabel?.textColor = .white
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.addNewCity(name: cityName, id: cityID[indexPath.row])
        delegate?.didAddedNewCity(true)
        dismiss(animated: true, completion: nil)
    }
}
