//
//  APIWeatherManager.swift
//  WeatherApp
//
//  Created by Александр Цветков on 01.02.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import Foundation

struct Coordinates {
    let latitude: Double
    let longitude: Double
}

enum ForecastType: FinalURLPoint {
    var baseURL: URL {
        return URL(string: "https://api.darksky.net")!
    }
    
    var path: String {
        switch self {
            case .Current(let apiKey, let coordinates):
                return "/forecast/\(apiKey)/\(coordinates.latitude),\(coordinates.longitude)?exclude=hourly,minutely,daily,alerts,flags"
        }
    }
    
    var request: URLRequest {
        let url = URL(string: path, relativeTo: baseURL)
        return URLRequest(url: url!)
    }
    case Current(apiKey: String, coordinates: Coordinates)
}

final class APIWeatherManager: APIManager {
    var sessionConfiguration: URLSessionConfiguration
    
    lazy var session: URLSession = {
        return URLSession(configuration: self.sessionConfiguration)
    } ()
    
    let apiKey: String
    init(sessionConfiguration: URLSessionConfiguration, apiKey: String) {
        self.sessionConfiguration = sessionConfiguration
        self.apiKey = apiKey
    }
    
    convenience init(apiKey: String) {
        self.init(sessionConfiguration: URLSessionConfiguration.default, apiKey: apiKey)
    }
    
    func fetchCurrentWeatherWith(coordinates: Coordinates, completionHandler: @escaping (APIResult<CurrentWeather>) -> Void ) {
        let request = ForecastType.Current(apiKey: self.apiKey, coordinates: coordinates).request
        fetch(request: request, parse: { (json) -> CurrentWeather? in
            if let dictionary = json["currently"] as? [String: AnyObject] {
                return CurrentWeather(JSON: dictionary)
            } else {
                return nil
            }
        }, completionHandler: completionHandler)
    }
}
