//
//  StringExtension.swift
//  WeatherBoy
//
//  Created by Pavlo Novak on 2022-03-27.
//

import Foundation

extension String {
    func formatToClockString(with timeZone: String) -> String {
        let dateString = self
        let formatter = DateFormatter()

        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSZZZZ"
        formatter.timeZone = TimeZone(identifier: timeZone)
        let date = formatter.date(from: dateString)
        formatter.dateFormat = "HH:mm"
        let formattedString = formatter.string(from: date ?? Date())
        
        return formattedString
    }
}
