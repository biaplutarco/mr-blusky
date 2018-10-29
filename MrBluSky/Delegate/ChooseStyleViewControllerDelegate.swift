//
//  ChooseStyleViewControllerDelegate.swift
//  MrBluSky
//
//  Created by Bia Plutarco on 28/10/18.
//  Copyright © 2018 Bia Plutarco. All rights reserved.
//

import UIKit

protocol ChooseStyleViewControllerDelegate {
    func saveWeatherStyle(_ style: UIImage, typeWeather: TypeWeather)
}
