//
//  CurrentWeather.swift
//  MrBluSky
//
//  Created by Bia Plutarco on 26/10/18.
//  Copyright © 2018 Bia Plutarco. All rights reserved.
//

import Foundation

struct CurrentWeather: Codable {
    var name: String
    var data: CurrentData
}
