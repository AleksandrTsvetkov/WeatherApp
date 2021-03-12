//
//  ViewController.swift
//  WeatherApp
//
//  Created by Александр Цветков on 30.01.2020.
//  Copyright © 2020 Александр Цветков. All rights reserved.
//
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var apparentTemperatureLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    let weatherManager = APIWeatherManager(apiKey: "5b2e4f1aca3c2c84ddcda0d35ece66ba")
    let coordinates = Coordinates(latitude: 35.0, longitude: 35.0)
    
    // MARK: FUNCTIONS
    @IBAction func refreshButtonPressed(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherManager.fetchCurrentWeatherWith(coordinates: coordinates) { (result) in
            switch result {
                case .Success(let currentWeather):
                    self.updateUIWith(currentWeather: currentWeather)
                case .Failure(let error as NSError):
                    print(error.localizedDescription)
            }
        }
    }

    func updateUIWith(currentWeather: CurrentWeather) {
        self.imageView.image = currentWeather.icon
        self.pressureLabel.text = currentWeather.pressureString
        self.temperatureLabel.text = currentWeather.temperatureString
        self.apparentTemperatureLabel.text = currentWeather.apparentTemperatureString
        self.humidityLabel.text = currentWeather.humidityString
    }
}

