//
//  Weather.swift
//  WeatherBoy
//
//  Created by Pavlo Novak on 2022-03-26.
//

import Foundation

struct Weather: Decodable {
    let id: Int
    let weatherState: String
    let weatherStateCode: String
    let date: String
    let minTemperature: Double
    let maxTemperature: Double
    let currentTemperature: Double
    let humidity: Int

    enum CodingKeys: String, CodingKey {
        case id
        case weatherState = "weather_state_name"
        case weatherStateCode = "weather_state_abbr"
        case date = "applicable_date"
        case minTemperature = "min_temp"
        case maxTemperature = "max_temp"
        case currentTemperature = "the_temp"
        case humidity
    }
}

extension Weather: Equatable {
    static func == (lhs: Weather, rhs: Weather) -> Bool {
        return lhs.id == rhs.id
    }
}
