//
//  CurrentData.swift
//  MrBluSky
//
//  Created by Bia Plutarco on 26/10/18.
//  Copyright © 2018 Bia Plutarco. All rights reserved.
//

import Foundation

struct CurrentData: Codable {
    var temperature: Double
    var humidity: Double
    var condition: String
    
    var temperatureInt: Int {
        return Int(temperature)
    }
    
    var humidityInt: Int {
        return Int(humidity)
    }
}
