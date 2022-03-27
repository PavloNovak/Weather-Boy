//
//  CityViewModelRepresentable.swift
//  WeatherBoy
//
//  Created by Pavlo Novak on 2022-03-26.
//

import Foundation

protocol CityViewModelRepresentable: AnyObject {
    /// Title of a city
    var title: String { get }
    /// Array containing weather forecasts for a city for next five days
    var weather: [Weather] { get }
    /// Local time for a city
    var localTime: String { get }
    /// Sunrise by local time for a city
    var sunRise: String { get }
    /// Sunset by local time for a city
    var sunSet: String { get }
    /// Local timezone identifier
    var timezone: String { get }
}
