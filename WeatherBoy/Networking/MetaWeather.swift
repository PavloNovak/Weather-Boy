//
//  MetaWeather.swift
//  WeatherBoy
//
//  Created by Pavlo Novak on 2022-03-26.
//

import Foundation

enum MetaWeather: String, CaseIterable {
    case gothenburg = "Gothenburg"
    case stockholm = "Stockholm"
    case mountainView = "Mountain View"
    case london = "London"
    case newYork = "New York"
    case berlin = "Berlin"
}

extension MetaWeather: APIService {
    
    var baseURL: String {
        return "https://www.metaweather.com/api/location/"
    }
    
    var path: String {
        switch self {
        case .gothenburg:
            return "890869"
        case .stockholm:
            return "906057"
        case .mountainView:
            return "2455920"
        case .london:
            return "44418"
        case .newYork:
            return "2459115"
        case .berlin:
            return "638242"
        }
    }
    
    var parameters: String {
        return ""
    }
}

extension MetaWeather {
    func country() -> String {
        switch self {
        case .gothenburg, .stockholm:
            return "Sweden"
        case .mountainView, .newYork:
            return "United States"
        case .london:
            return "England"
        case .berlin:
            return "Germany"
        }
    }
}
