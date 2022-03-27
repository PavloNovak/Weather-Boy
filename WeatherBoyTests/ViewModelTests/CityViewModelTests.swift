//
//  CityViewModelTests.swift
//  WeatherBoyTests
//
//  Created by Pavlo Novak on 2022-03-26.
//

import Foundation
import XCTest
@testable import WeatherBoy

class CityViewModelTests: XCTestCase {
    
    let expectation = XCTestExpectation(description: "response")
    
    var urlSession: URLSession!
    
    override func setUpWithError() throws {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [DummyURLProtocol.self]
        urlSession = URLSession(configuration: configuration)
    }
    
    func testCityViewModel() throws {
        // Arrange
        let apiManager = APIManager(urlSession: urlSession)
        
        let viewModel = CityViewModel(apiManager: apiManager)
        
        // Act & Assert
        viewModel.fetchCityDataByIndex(0)
        viewModel.delegate = self
        wait(for: [expectation], timeout: 3)
    }
    
    func testCityViewModelRepresentable() {
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
                                  localTime: "2022-03-26T00:16:48.696329-07:00",
                                  sunRise: "2022-03-26T07:02:36.211117-07:00",
                                  sunSet: "2022-03-26T19:24:54.135109-07:00",
                                  timeZoneIdentifier: "America/Los_Angeles")
        let viewModel = CityViewModel(model: expectedResult)
        
        // Act & Assert
        XCTAssertEqual(viewModel.title, expectedResult.title)
        XCTAssertEqual(viewModel.weather, expectedResult.weather)
        XCTAssertEqual(viewModel.localTime, expectedResult.localTime)
        XCTAssertEqual(viewModel.sunRise, expectedResult.sunRise)
        XCTAssertEqual(viewModel.sunSet, expectedResult.sunSet)
        XCTAssertEqual(viewModel.timezone, expectedResult.timeZoneIdentifier)
    }
}

extension CityViewModelTests: CityViewModelDelegate {
    func didUpdateData() {
        expectation.fulfill()
    }
    
    func didOccurError(withMessage message: String) {
        XCTFail(message)
    }
}
