//
//  City.swift
//  WeatherBoy
//
//  Created by Pavlo Novak on 2022-03-26.
//

import Foundation

struct City: Decodable {
    let title: String
    let weather: [Weather]
    let localTime: String
    let sunRise: String
    let sunSet: String

    enum CodingKeys: String, CodingKey {
        case title
        case weather = "consolidated_weather"
        case localTime = "time"
        case sunRise = "sun_rise"
        case sunSet = "sun_set"
    }
}

extension City: Equatable {
    static func == (lhs: City, rhs: City) -> Bool {
        return lhs.title == rhs.title
        && lhs.localTime == rhs.localTime
        && lhs.sunRise == rhs.sunRise
        && lhs.sunSet == rhs.sunSet
        && lhs.weather == rhs.weather
    }
}
