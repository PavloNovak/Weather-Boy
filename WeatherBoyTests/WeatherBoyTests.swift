//
//  WeatherBoyTests.swift
//  WeatherBoyTests
//
//  Created by Pavlo Novak on 2022-03-26.
//

import XCTest
@testable import WeatherBoy

class WeatherBoyTests: XCTestCase {

    func testRequestBuilding() {
        // Arrange
        let expectedResult = URL(string: "https://www.metaweather.com/api/location/2455920")
        
        // Act
        let request = MetaWeather.mountainView.request
        
        // Assert
        XCTAssertNotNil(request)
        XCTAssertEqual(expectedResult, request)
    }
}
