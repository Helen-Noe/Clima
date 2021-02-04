//
//  WeatherManager.swift
//  Clima
//
//  Created by Thin Myat Noe on 1/2/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager{
	let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=4598c84e00ea79c08bcbd1461ea1866a&units=metric"
	
	func fetchWeather(cityName: String){
		let urlString = "\(weatherURL)&q=\(cityName)"
		performRequest(urlString: urlString)
	}
	
	func performRequest (urlString: String){
		// 1. Create URL
		if let url = URL(string: urlString){
			
		// 2. Create URL Session
		let session = URLSession(configuration: .default)
			
		// 3. Give Session a Task
			let task = session.dataTask(with: url) { (data, response, error) in
				if error != nil{
					print(error!)
					return
				}
				
				if let safeData = data{
//					let stringData = String(data: safeData, encoding: .utf8)
//					print(stringData)
					parseJSON(weatherData: safeData)
				}
			}
			
		// 4. Start the task
		task.resume()
		}
	}
	
	func parseJSON(weatherData: Data){
		let decoder = JSONDecoder()
		do{
			let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
			
			let id = decodedData.weather[0].id
			let temp = decodedData.main.temp
			let city = decodedData.name
			
			let weather = WeatherModel(conditionID: id, cityName: city, temp: temp)
			
			print(weather.conditionName)
			print(weather.tempString)
			
		} catch{
			print(error)
		}
	}
	
}
