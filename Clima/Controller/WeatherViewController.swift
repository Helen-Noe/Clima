//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate {
	
	
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
	@IBOutlet weak var searchTextField: UITextField!
	
	var weatherManager = WeatherManager()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		weatherManager.delegate = self
		searchTextField.delegate = self
    }

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
	
	func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel){
		temperatureLabel.text = weather.tempString
	}
	
	func didFailWithError(error: Error) {
		print(error)
	}
}

