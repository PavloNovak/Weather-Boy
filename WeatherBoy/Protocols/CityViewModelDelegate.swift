//
//  CityViewModelDelegate.swift
//  WeatherBoy
//
//  Created by Pavlo Novak on 2022-03-26.
//

import Foundation

/// Conform to implement handling of CityViewModel requests updates
protocol CityViewModelDelegate: AnyObject {

    /// Called when receives data from the network request.
    func didUpdateData()

    /// Called when error occured after network request
    /// - Parameters:
    ///     - message: Error message.
    func didOccurError(withMessage message: String)
}
