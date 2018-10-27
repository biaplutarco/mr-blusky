//
//  ClimaTempoAPIManager.swift
//  MrBluSky
//
//  Created by Bia Plutarco on 24/10/18.
//  Copyright © 2018 Bia Plutarco. All rights reserved.
//

import Foundation

class ClimaTempoAPIManager: NSObject {
    
    static let sharedInstance = ClimaTempoAPIManager()
    var currentLatidude = Double()
    var currentLongitude = Double()
    
    func getCityIDRequestBy(name: String, completion: @escaping ([Object]?) -> Void) {
        let rawUrl: String = "https://apiadvisor.climatempo.com.br/api/v1/locale/city?name=\(name)&token=38aec79cfe4481307d653757766e1843"
        let urlEncoded = rawUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard let url = URL(string: urlEncoded!) else {
            print("Error: cannot create URL")
            return
        }
        var getRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30)
        getRequest.httpMethod = "GET"
        let getTask = URLSession.shared.dataTask(with: getRequest) { (data, response, error) in
            if error != nil {
                print ("GET Request in \(getRequest) Error: \(error!)") }
            if data != nil {
                do {
                    let resultObject = try JSONDecoder().decode([Object].self, from: data!)
                    completion(resultObject)
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
    
    func getCityCurrentWeather(id: Int16, completion: @escaping (CurrentWeather?) -> Void) {
        let rawUrl: String = "https://apiadvisor.climatempo.com.br/api/v1/weather/locale/\(id)/current?token=38aec79cfe4481307d653757766e1843"
        let urlEncoded = rawUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard let url = URL(string: urlEncoded!) else {
            print("Error: cannot create URL")
            return
        }
        var getRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30)
        getRequest.httpMethod = "GET"
        let getTask = URLSession.shared.dataTask(with: getRequest) { (data, response, error) in
            if error != nil {
                print ("GET Request in \(getRequest) Error: \(error!)") }
            if data != nil {
                do {
                    let resultObject = try JSONDecoder().decode(CurrentWeather.self, from: data!)
                    completion(resultObject)
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
    
    func getCityForecast(id: Int16, completion: @escaping (Forecast?) -> Void) {
        let rawUrl: String = "https://apiadvisor.climatempo.com.br/api/v1/forecast/locale/\(id)/days/15?token=38aec79cfe4481307d653757766e1843"
        let urlEncoded = rawUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        guard let url = URL(string: urlEncoded!) else {
            print("Error: cannot create URL")
            return
        }
        var getRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30)
        getRequest.httpMethod = "GET"
        let getTask = URLSession.shared.dataTask(with: getRequest) { (data, response, error) in
            if error != nil {
                print ("GET Request in \(getRequest) Error: \(error!)") }
            if data != nil {
                do {
                    let resultObject = try JSONDecoder().decode(Forecast.self, from: data!)
                    completion(resultObject)
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
        
        
//
//    func getRequest(completion: @escaping (Response) -> Void){
//        let getURL = URL(string: "https://api.darksky.net/forecast/0b49fe0d0f1420c17458a58c18062115/\(currentLatidude),\(currentLongitude)")!
//        var getRequest = URLRequest(url: getURL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30)
//        getRequest.httpMethod = "GET"
//        let getTask = URLSession.shared.dataTask(with: getRequest) { (data, response, error) in
//            if error != nil {
//                print ("GET Request in \(getRequest) Error: \(error!)") }
//            if data != nil {
//                do {
//                    let resultObject = try JSONDecoder().decode(Response.self, from: data!)
//                    completion(Response(currently: resultObject.currently, daily: resultObject.daily, hourly: resultObject.hourly))
//                } catch let parserError {
//                    DispatchQueue.main.async {
//                        print(parserError)
//                        print("Unable to parse JSON response in \(getRequest)")
//                    }
//                }
//            } else {
//                print ("Received empty quest response from \(getRequest)")
//            }
//        }
//        DispatchQueue.global(qos: .background).async {
//            getTask.resume()
//        }
//    }
}
