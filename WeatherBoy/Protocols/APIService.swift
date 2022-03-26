//
//  APIService.swift
//  WeatherBoy
//
//  Created by Pavlo Novak on 2022-03-26.
//

import Foundation

protocol APIService {
    /// Target base URL
    var baseURL: String { get }
    /// The path to be appended to baseURL
    var path: String { get }
}

extension APIService {
    /// Full URL request
    var request: URL? {
        URL(string: constructRequest())
    }

    private func constructRequest() -> String {
        
        var url = baseURL
        url.append(contentsOf: path)
        return url
    }
}
