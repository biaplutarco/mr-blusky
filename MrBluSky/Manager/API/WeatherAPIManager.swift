//
//  APIManager.swift
//  MrBluSky
//
//  Created by Bia Plutarco on 18/10/18.
//  Copyright © 2018 Bia Plutarco. All rights reserved.
//

import UIKit
import MapKit

class WeatherAPIManager: NSObject {
    
    static let sharedInstance = WeatherAPIManager()
    var currentLatidude = Double()
    var currentLongitude = Double()
    
    func getRequest(completion: @escaping (Response) -> Void){
        let getURL = URL(string: "https://api.darksky.net/forecast/0b49fe0d0f1420c17458a58c18062115/\(currentLatidude),\(currentLongitude)")!
        var getRequest = URLRequest(url: getURL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30)
        getRequest.httpMethod = "GET"
        let getTask = URLSession.shared.dataTask(with: getRequest) { (data, response, error) in
            if error != nil {
                print ("GET Request in \(getRequest) Error: \(error!)") }
            if data != nil {
                do {
                    let resultObject = try JSONDecoder().decode(Response.self, from: data!)
                    completion(Response(currently: resultObject.currently, daily: resultObject.daily, hourly: resultObject.hourly))
                } catch let parserError {
                    DispatchQueue.main.async {
                        print(parserError)
                        print("Unable to parse JSON response in \(getRequest)")
                    }
                }
            } else {
                print ("Received empty quest response from \(getRequest)")
            }
        }
        DispatchQueue.global(qos: .background).async {
            getTask.resume()
        }
    }
}
