//
//  DayCollectionView.swift
//  MrBluSky
//
//  Created by Bia Plutarco on 20/10/18.
//  Copyright © 2018 Bia Plutarco. All rights reserved.
//

import UIKit

class DayCollectionView: UICollectionView {
    func timestampFormatter(_ timestamp: Double) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        let formatter = DateFormatter()
        formatter.dateFormat = "EE"
        let dayInWeek = formatter.string(from: date)
        
        return dayInWeek
    }
    
    func setCollectionData(response: Response) -> [Day] {
        var days = [Day]()
        let daily = response.daily.data
        print(daily)
        daily.forEach({ (daily) in
            let nameDay = self.timestampFormatter(daily.time)
            days.append(Day(nameDay: nameDay, tempHigh: "\(daily.temperatureHighCelsius)°", tempLow: "\(daily.temperatureLowCelsius)°", icon: daily.icon))
        })
        return days
    }
}
