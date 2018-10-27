//
//  TodayViewController.swift
//  Widgets
//
//  Created by Bia Plutarco on 23/10/18.
//  Copyright © 2018 Bia Plutarco. All rights reserved.
//

import UIKit
import NotificationCenter
import MapKit

class TodayViewController: UIViewController, NCWidgetProviding {
        
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var currentlyTemp: UILabel!
    @IBOutlet weak var highLowTemp: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        visualEffectView.effect = UIVibrancyEffect.widgetPrimary()
        
        setContentWidget()
    }
    
    func setContentWidget() {
        if let textFromApp = UserDefaults.init(suiteName: "group.com.biaplutarco.mrblusky")?.value(forKey: "text") {
            summary.text = textFromApp as? String
        }
        
        if let currentTempFromApp = UserDefaults.init(suiteName: "group.com.biaplutarco.mrblusky")?.value(forKey: "currentTemp") {
            currentlyTemp.text = currentTempFromApp as? String
        }
        
        if let cityNameFromApp = UserDefaults.init(suiteName: "group.com.biaplutarco.mrblusky")?.value(forKey: "cityName") {
            cityName.text = cityNameFromApp as? String
        }
        
        if let tempHighFromApp = UserDefaults.init(suiteName: "group.com.biaplutarco.mrblusky")?.value(forKey: "tempHigh") {
            highLowTemp.text = tempHighFromApp as? String
        }
        
        if let tempLowFromApp = UserDefaults.init(suiteName: "group.com.biaplutarco.mrblusky")?.value(forKey: "tempLow") {
            let tempLow = tempLowFromApp as? String
            highLowTemp.text?.append("/")
            highLowTemp.text?.append(tempLow!)
        }
        
        
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        if let cityNamefromApp = UserDefaults.init(suiteName: "group.com.biaplutarco.mrblusky")?.value(forKey: "cityName") {
            if cityNamefromApp as? String != cityName.text {
                cityName.text = cityNamefromApp as? String
                completionHandler(NCUpdateResult.newData)
            } else {
                completionHandler(NCUpdateResult.noData)
            }
        } else {
            cityName.text = "Abra o app e cheque a previsão do tempo hoje!"
            completionHandler(NCUpdateResult.newData)
        }
        
        
        if let textFromApp = UserDefaults.init(suiteName: "group.com.biaplutarco.mrblusky")?.value(forKey: "text") {
            if textFromApp as? String != summary.text {
                summary.text = textFromApp as? String
                completionHandler(NCUpdateResult.newData)
            } else {
                completionHandler(NCUpdateResult.noData)
            }
        } else {
            summary.text = ""
            completionHandler(NCUpdateResult.newData)
        }
        
        if let currentTempFromApp = UserDefaults.init(suiteName: "group.com.biaplutarco.mrblusky")?.value(forKey: "currentTemp") {
            if currentTempFromApp as? String != currentlyTemp.text {
                currentlyTemp.text = currentTempFromApp as? String
                completionHandler(NCUpdateResult.newData)
            } else {
                completionHandler(NCUpdateResult.noData)
            }
        } else {
            currentlyTemp.text = ""
            completionHandler(NCUpdateResult.newData)
        }
        
        if let tempHighFromApp = UserDefaults.init(suiteName: "group.com.biaplutarco.mrblusky")?.value(forKey: "tempHigh") {
            if let tempLowFromApp = UserDefaults.init(suiteName: "group.com.biaplutarco.mrblusky")?.value(forKey: "tempLow") {
                if tempHighFromApp as? String != highLowTemp.text {
                    highLowTemp.text = tempHighFromApp as? String
                    completionHandler(NCUpdateResult.newData)
                } else {
                    completionHandler(NCUpdateResult.noData)
                }
                
                if let tempLow = tempLowFromApp as? String {
                    highLowTemp.text?.append("/")
                    highLowTemp.text?.append(tempLow)
                    completionHandler(NCUpdateResult.newData)
                } else {
                    completionHandler(NCUpdateResult.noData)
                }
            }
            
        } else {
            highLowTemp.text = ""
            completionHandler(NCUpdateResult.newData)
        }
    
    }
}



