//
//  Daily.swift
//  MrBluSky
//
//  Created by Bia Plutarco on 18/10/18.
//  Copyright © 2018 Bia Plutarco. All rights reserved.
//

import Foundation

struct Daily: Codable {
    var data: [DailyData]
}

struct DailyData: Codable {
    var summary: String
    var time: Double
    var icon: String
    
    var temperatureHigh: Double
    var temperatureHighCelsius: Int {
        return Int((temperatureHigh-32) * 5/9)
    }
    
    var temperatureLow: Double
    var temperatureLowCelsius: Int {
        return Int((temperatureLow-32) * 5/9)
    }
}
