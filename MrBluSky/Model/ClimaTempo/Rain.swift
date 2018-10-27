//
//  Rain.swift
//  MrBluSky
//
//  Created by Bia Plutarco on 26/10/18.
//  Copyright © 2018 Bia Plutarco. All rights reserved.
//

import Foundation

struct Rain: Codable {
    var probability: Double
    var probabilityInt: Int {
        return Int(probability)
    }
}
