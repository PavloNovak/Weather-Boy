//
//  APIManagerTests.swift
//  WeatherBoyTests
//
//  Created by Pavlo Novak on 2022-03-26.
//

import Foundation
import XCTest
@testable import WeatherBoy

class APIManagerTests: XCTestCase {
    
    var urlSession: URLSession!
    
    override func setUpWithError() throws {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [DummyURLProtocol.self]
        urlSession = URLSession(configuration: configuration)
    }
    
    func testRequestBuilding() {
        // Arrange
        let expectedResult = URL(string: "https://www.metaweather.com/api/location/2455920")
        
        // Act
        let request = MetaWeather.mountainView.requestString
        let requestURL = URL(string: request)
        
        // Assert
        XCTAssertNotNil(requestURL)
        XCTAssertEqual(expectedResult, requestURL)
    }
    
    func testRequest() {
        // Arrange
        let apiManager = APIManager(urlSession: urlSession)
        
        let expectation = XCTestExpectation(description: "response")
        
        // Act & Assert
        apiManager.fetchCityData(from: MetaWeather.mountainView) { result in
            switch result {
            case .success(let city):
                XCTAssertFalse(city.weather.isEmpty)
            case .failure(let error):
                XCTFail(error.localizedDescription)
            
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3)
    }
}
