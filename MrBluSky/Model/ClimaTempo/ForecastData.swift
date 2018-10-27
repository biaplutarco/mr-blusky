//
//  ForecastData.swift
//  MrBluSky
//
//  Created by Bia Plutarco on 26/10/18.
//  Copyright © 2018 Bia Plutarco. All rights reserved.
//

import Foundation

struct ForecastData: Codable {
    var date: String
    var rain: Rain
    var temperature: Temperature
    var textIcon: TextIcon
    
    enum CodingKeys: String, CodingKey {
        case textIcon = "text_icon"
        case date
        case rain
        case temperature
    }
}
