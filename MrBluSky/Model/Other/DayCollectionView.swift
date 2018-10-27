//
//  DayCollectionView.swift
//  MrBluSky
//
//  Created by Bia Plutarco on 20/10/18.
//  Copyright © 2018 Bia Plutarco. All rights reserved.
//

import UIKit

class DayCollectionView: UICollectionView {
    func timestampFormatter(_ string: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" //Your date format
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00") //Current time zone
        //according to date format your date string
        guard let date = dateFormatter.date(from: string) else {
            fatalError()
        }
        
        let dateNow = Date(timeIntervalSince1970: date.timeIntervalSince1970)
        let formatter = DateFormatter()
        formatter.dateFormat = "EE"
        let dayInWeek = formatter.string(from: dateNow)
        
        return dayInWeek
    }
    
    func setCollectionData(forecast: Forecast) -> [Day] {
        var days = [Day]()
        let daily = forecast.data
        daily.forEach({ (daily) in
            //            let numberDay = (daily.date).prefix(2)
            let time = timestampFormatter(daily.date)
            days.append(Day(nameDay: time, tempHigh: "\(daily.temperature.maxInt)°", tempLow: "\(daily.temperature.minInt)°"))
        })
        return days
    }
}
