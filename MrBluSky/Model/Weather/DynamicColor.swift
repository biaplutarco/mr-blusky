//
//  DynamicColor.swift
//  MrBluSky
//
//  Created by Bia Plutarco on 20/10/18.
//  Copyright © 2018 Bia Plutarco. All rights reserved.
//

import UIKit

struct DynamicColor {
    func getColor(iconText: String) -> TypeWeather {
        let hour = Calendar.current.component(.hour, from: Date())
        if iconText.contains("cloudy") || iconText.contains("rain") || iconText.contains("snow") {
            return TypeWeather.rain
        } else {
            if hour > 16 {
                return TypeWeather.night
            } else {
                return TypeWeather.sun
            }
        }
    }
    
    func getFirstColor() -> TypeWeather {
        let hour = Calendar.current.component(.hour, from: Date())
        if hour > 16 {
            return TypeWeather.night
        } else {
            return TypeWeather.sun
        }
    }
    
    func getSrtingFromWeather(_ weather: TypeWeather) -> String {
        if weather == .sun {
            return "Sun"
        } else {
            return "Night"
        }
    }
    
    func setFisrtColor() -> String {
        let typeWeather = getFirstColor()
        return getSrtingFromWeather(typeWeather)
    }
}


enum TypeWeather {
    case sun
    case night
    case rain
    case snow
}
