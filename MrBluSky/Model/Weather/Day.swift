//
//  Day.swift
//  MrBluSky
//
//  Created by Bia Plutarco on 19/10/18.
//  Copyright © 2018 Bia Plutarco. All rights reserved.
//

import Foundation

struct Day {
    var nameDay: String
    var tempHigh: String
    var tempLow: String
    var icon: String
    
    init(nameDay: String, tempHigh: String, tempLow: String, icon: String) {
        self.nameDay = nameDay
        self.tempHigh = tempHigh
        self.tempLow = tempLow
        self.icon = icon
    }
}
