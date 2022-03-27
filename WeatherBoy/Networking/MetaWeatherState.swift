//
//  MetaWeatherState.swift
//  WeatherBoy
//
//  Created by Pavlo Novak on 2022-03-26.
//

import Foundation

enum MetaWeatherState {
    case image
}

extension MetaWeatherState: APIService {
    var baseURL: String {
        return "https://www.metaweather.com/"
    }
    
    var path: String {
        switch self {
        case .image:
            return "/static/img/weather/png/64/"
        }
    }
}
