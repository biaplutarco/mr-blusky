//
//  GeocodingAPIManager.swift
//  MrBluSky
//
//  Created by Bia Plutarco on 18/10/18.
//  Copyright © 2018 Bia Plutarco. All rights reserved.
//

import Foundation

class GeocodingAPIManager {
    
    static let sharedInstance = GeocodingAPIManager()
    var nameNewCity = String()
    var newLogitudeCity = Double()
    var newLatitudeCity = Double()
    var newTableViewData = [String]()
    
    func getRequest(completion: @escaping (ResponseResult) -> Void, errorComp: @escaping () -> Void){
        let getURL = URL(string: "https://api.opencagedata.com/geocode/v1/json?q=\(nameNewCity)&key=f19776cf7a26486ca991a0bcaaf8a8e9")!
        var getRequest = URLRequest(url: getURL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30)
        getRequest.httpMethod = "GET"
        let getTask = URLSession.shared.dataTask(with: getRequest) { (data, response, error) in
            if error != nil {
                print ("GET Request in \(getRequest) Error: \(error!)")
                
                DispatchQueue.main.async {
                    errorComp()
                }
            }
            if data != nil {
                do {
                    let resultObject = try JSONDecoder().decode(ResponseResult.self, from: data!)
                    print(resultObject)
                    completion(resultObject)
                } catch let parserError {
                    DispatchQueue.main.async {
                        print(parserError)
                        print("Unable to parse JSON response in \(getRequest)")
                        errorComp()
                    }
                }
            } else {
                
                DispatchQueue.main.async {
                    errorComp()
                }
                print ("Received empty quest response from \(getRequest)")
            }
        }
        DispatchQueue.global(qos: .background).async {
            getTask.resume()
        }
    }
}

