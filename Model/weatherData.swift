//
//  weatherData.swift
//  Clima
//
//  Created by Thin Myat Noe on 4/2/21.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Codable{
	let name: String
	let main: Main
	let weather: [Weather]
}

struct Main: Codable{
	let temp: Double
}

struct Weather: Codable{
	let id: Int
}
