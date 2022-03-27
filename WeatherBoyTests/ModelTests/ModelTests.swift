//
//  ModelTests.swift
//  WeatherBoyTests
//
//  Created by Pavlo Novak on 2022-03-26.
//

import XCTest
@testable import WeatherBoy

class ModelTests: XCTestCase {
    
    let resource: String = "metaweatherResponseExample"
    let resourceType: String = "json"
    
    func testJSONParsing() {
        // Arrange
        let expectedWeather: [Weather] = [Weather(id: 6531134142808064,
                                                  weatherState: "Light Cloud",
                                                  weatherStateCode: "lc",
                                                  date: "2022-03-26",
                                                  minTemperature: 8.19,
                                                  maxTemperature: 21.605,
                                                  currentTemperature: 20.48)]
        let expectedResult = City(title: "Mountain View",
                                  weather: expectedWeather,
                                  sunRise: "2022-03-26T07:02:36.211117-07:00",
                                  sunSet: "2022-03-26T19:24:54.135109-07:00")
        
        // Act
        if let path = Bundle.main.url(forResource: resource, withExtension: resourceType) {
            do {
                let data = try Data(contentsOf: path)
                let cityObject = try JSONDecoder().decode(City.self, from: data)
                
                // Assert
                XCTAssertEqual(cityObject, expectedResult)
            } catch let error {
                XCTFail("\(error)")
            }
        } else {
            XCTFail("Could not find \(resource) file")
        }
    }
}
