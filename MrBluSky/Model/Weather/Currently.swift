//
//  Currently.swift
//  MrBluSky
//
//  Created by Bia Plutarco on 18/10/18.
//  Copyright © 2018 Bia Plutarco. All rights reserved.
//

import Foundation

struct Currently: Codable {
    var summary: String
    var icon: String
    
    var temperature: Double
    var temperatureCelsius: Int {
        return Int((temperature-32) * 5/9)
    }
    
    var humidity: Double
    var humidityPercent: Int {
        return Int(humidity * 100)
    }
    
    var precipProbability: Double
    var precipProbabilityPercent: Int {
        return Int(precipProbability * 100)
    }
}

