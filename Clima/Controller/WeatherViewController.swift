//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController{
	
	
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
	@IBOutlet weak var searchTextField: UITextField!
	
	var weatherManager = WeatherManager()
	let locationManager = CLLocationManager()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		locationManager.delegate = self
		locationManager.requestWhenInUseAuthorization()
		locationManager.requestLocation()
		
		weatherManager.delegate = self
		searchTextField.delegate = self
		
    }
	@IBAction func locationPressed(_ sender: UIButton) {
		locationManager.requestLocation()
	}
}

// MARK: - UITextFieldDelegate

extension WeatherViewController: UITextFieldDelegate{
	@IBAction func searchPressed(_ sender: UIButton) {
		print(searchTextField.text!)
		searchTextField.endEditing(true)
	}
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		searchTextField.endEditing(true)
		return true
	}
	
	func textFieldDidEndEditing(_ textField: UITextField) {
		
		// use searchTextField.text to get the weatherfor that city
		if let city = searchTextField.text{
			weatherManager.fetchWeather(cityName: city)
		}
		
		
		searchTextField.text = ""
	}
	
	func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
		if searchTextField.text != ""{
			return true
		} else{
			searchTextField.placeholder = "Type A City Name"
			return false
		}
	}
}

// MARK: - WeatherManagerDelegate

extension WeatherViewController: WeatherManagerDelegate{
	func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel){
		DispatchQueue.main.sync {
			temperatureLabel.text = weather.tempString
			conditionImageView.image = UIImage(systemName: weather.conditionName)
			cityLabel.text = weather.cityName
		}
	}
	
	func didFailWithError(error: Error) {
		print(error)
	}
}

// MARK: - CLLocationManagerDelegate

extension WeatherViewController: CLLocationManagerDelegate{
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		if let location = locations.last{
			locationManager.stopUpdatingLocation()
			let lat = location.coordinate.latitude
			let lon = location.coordinate.longitude
			
			weatherManager.fetchWeather(latitude: lat, longitude: lon)
			print(lat)
			print(lon)
		}
		
	}
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		print(error)
	}
}

