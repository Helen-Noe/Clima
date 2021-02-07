//
//  WeatherManager.swift
//  Clima
//
//  Created by Thin Myat Noe on 1/2/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
	func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
	func didFailWithError(error: Error)
}

struct WeatherManager{
	
	var delegate: WeatherManagerDelegate?
	
	let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=4598c84e00ea79c08bcbd1461ea1866a&units=metric"
	
	func fetchWeather(cityName: String){
		let urlString = "\(weatherURL)&q=\(cityName)"
		performRequest(urlString: urlString)
	}
	
	func fetchWeather(latitude: Double, longitude: Double){
		let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
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
					delegate?.didFailWithError(error: error!)
					return
				}
				
				if let safeData = data{
//					let stringData = String(data: safeData, encoding: .utf8)
//					print(stringData)
					if let weather  = parseJSON(safeData){
						delegate?.didUpdateWeather(self, weather: weather)
					}
				}
			}
			
		// 4. Start the task
		task.resume()
		}
	}
	
	func parseJSON(_ weatherData: Data) -> WeatherModel?{
		let decoder = JSONDecoder()
		do{
			let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
			
			let id = decodedData.weather[0].id
			let temp = decodedData.main.temp
			let city = decodedData.name
			
			let weather = WeatherModel(conditionID: id, cityName: city, temp: temp)
			
			
//			print(weather.conditionName)
//			print(weather.tempString)
			return weather
			
		} catch{
			delegate?.didFailWithError(error: error)
			return nil
		}
	}
	
}
