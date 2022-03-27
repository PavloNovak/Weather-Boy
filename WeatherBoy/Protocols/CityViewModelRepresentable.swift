//
//  CityViewModelRepresentable.swift
//  WeatherBoy
//
//  Created by Pavlo Novak on 2022-03-26.
//

import Foundation

protocol CityViewModelRepresentable: AnyObject {
    /// Return title of a city
    var title: String { get }
    /// Returns array containing weather forecasts for a city
    var weather: [Weather] { get }
    /// Returns local time for a city
    var localTime: String { get }
    /// Returns sunrise local time for a city
    var sunRise: String { get }
    /// Returns sunset local time for a city
    var sunSet: String { get }
    /// Returns local timezone identifier
    var timezone: String { get }
}
