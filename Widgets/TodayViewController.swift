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
    
    let locationManager = CLLocationManager()
    var currentlyLocation = CLLocation()
    var widgetContent: WidgetContent?
    
    let weatherAPI = WeatherAPIManager.sharedInstance
    let geocodingAPI = GeocodingAPIManager.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        visualEffectView.effect = UIVibrancyEffect.widgetPrimary()
        
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self as CLLocationManagerDelegate
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        // Do any additional setup after loading the view from its nib.
        }
        
        
        setContentWidget()
    }
    
    func setContentWidget() {
        weatherAPI.currentLatidude = currentlyLocation.coordinate.latitude
        weatherAPI.currentLongitude = currentlyLocation.coordinate.longitude
        
        weatherAPI.getRequest { (response) in
            self.summary.text = response.hourly.summary
            self.currentlyTemp.text = "\(response.currently.temperatureCelsius)°"
            
            let days = response.daily.data
            days.forEach({ (day) in
                self.highLowTemp.text = "\(day.temperatureHighCelsius)°/\(day.temperatureLowCelsius)°"
                
                self.geocodingAPI.newLatitudeCity = self.currentlyLocation.coordinate.latitude
                self.geocodingAPI.newLogitudeCity = self.currentlyLocation.coordinate.longitude
                self.geocodingAPI.getRequest(completion: { (responseGeo) in
                    let results = responseGeo.results
                    
                    results.forEach({ (result) in
                        self.cityName.text = result.components.city!
                        self.widgetContent = WidgetContent(summary: response.hourly.summary,
                                                           currentlyTemp: "\(response.currently.temperatureCelsius)°",
                            highLow: "\(day.temperatureHighCelsius)°/\(day.temperatureLowCelsius)°", cityName: result.components.city!)
                    })
                }) {
                    print("error")
                }
            })
        }
        
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        if widgetContent != nil  {
            setContentWidget()
            completionHandler(.newData)
        }else {
            completionHandler(.failed)
        }
        
    }
    
}


extension TodayViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        currentlyLocation = CLLocation(latitude: locValue.latitude, longitude: locValue.longitude)
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
    
}


struct WidgetContent {
    var summary: String
    var currentlyTemp: String
    var highLow: String
    var cityName: String
}


