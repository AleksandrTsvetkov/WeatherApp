//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Александр Цветков on 30.01.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//

import UIKit

struct CurrentWeather {
    let temperature: Double
    let apparentTemperature: Double
    let humidity: Double
    let pressure: Double
    let icon: UIImage
}

extension CurrentWeather {
  var pressureString: String {
    return "\(Int(pressure * 0.750062)) mm"
  }
  
  var humidityString: String {
    return "\(Int(humidity * 10)) %"
  }
  
  var temperatureString: String {
    return "\(Int(5 / 9 * (temperature - 32)))˚C"
  }
  
  var apparentTemperatureString: String {
    return "Feels like: \(Int(5 / 9 * (apparentTemperature - 32)))˚C"
  }
}

extension CurrentWeather: JSONDecodable {
    init?(JSON: [String : AnyObject]) {
        guard let temperature = JSON["temperature"] as? Double, let apparentTemperature = JSON["apparentTemperature"] as? Double, let humidity = JSON["humidity"] as? Double, let pressure = JSON["pressure"] as? Double, let iconString = JSON["icon"] as? String else { return nil }
        let icon = WeatherIconManager(rawValue: iconString).image
        self.temperature = temperature
        self.apparentTemperature = apparentTemperature
        self.humidity = humidity
        self.pressure = pressure
        self.icon = icon
    }
}
