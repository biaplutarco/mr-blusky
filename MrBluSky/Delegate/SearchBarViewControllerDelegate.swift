//
//  SearchBarViewControllerDelegate.swift
//  MrBluSky
//
//  Created by Bia Plutarco on 18/10/18.
//  Copyright © 2018 Bia Plutarco. All rights reserved.
//

import UIKit

protocol SearchBarViewControllerDelegate {
    func addNewCity(name: String, id: Int16)
    func didAddedNewCity(_ bool: Bool)
}


