//
//  Temperature.swift
//  MrBluSky
//
//  Created by Bia Plutarco on 26/10/18.
//  Copyright © 2018 Bia Plutarco. All rights reserved.
//

import Foundation

struct Temperature: Codable {
    var min: Double
    var minInt: Int {
        return Int(min)
    }
    var max: Double
    var maxInt: Int {
        return Int(max)
    }
}
