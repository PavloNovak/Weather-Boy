//
//  StringTests.swift
//  WeatherBoyTests
//
//  Created by Pavlo Novak on 2022-03-27.
//

import XCTest
@testable import WeatherBoy

final class StringTests: XCTestCase {
    func testFormatter() {
        let dateString = "2022-03-26T19:24:54.135109-07:00"
        let expectedResult = "19:24"
        
        let result = dateString.formatToClockString(with: "America/Los_Angeles")
        
        XCTAssertEqual(expectedResult, result)
    }
}
