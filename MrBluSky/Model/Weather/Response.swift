//
//  Response.swift
//  MrBluSky
//
//  Created by Bia Plutarco on 18/10/18.
//  Copyright © 2018 Bia Plutarco. All rights reserved.
//

import Foundation

struct Response: Codable {
    var currently: Currently
    var daily: Daily
    var hourly: Hourly
}
