//
//  Componet.swift
//  MrBluSky
//
//  Created by Bia Plutarco on 19/10/18.
//  Copyright © 2018 Bia Plutarco. All rights reserved.
//

import Foundation

struct Component: Codable {
    var city: String?
    var state: String
    var country: String
    var type: String
    
    enum CodingKeys: String, CodingKey {
        case type = "_type"
        case city
        case state
        case country
    }
}
