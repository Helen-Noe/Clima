//
//  WeatherManager.swift
//  Clima
//
//  Created by Thin Myat Noe on 1/2/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager{
	let weatherURL = "http://api.openweathermap.org/data/2.5/weather?appid=4598c84e00ea79c08bcbd1461ea1866a&units=metric"
	
	func fetchWeather(cityName: String){
		let urlString = "\(weatherURL)&q=\(cityName)"
		print(urlString)
	}
}
