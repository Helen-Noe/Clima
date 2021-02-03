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
		let task = session.dataTask(with: url, completionHandler: handle(data:response:error:))
			
		// 4. Start the task
		task.resume()
		}
	}
	
	func handle(data: Data?, response: URLResponse?, error: Error?){
		if error != nil{
			print(error!)
			return
		}
		
		if let safeData = data{
			let stringData = String(data: safeData, encoding: .utf8)
			print(stringData)
		}
	}
}
