//
//  APIManager.swift
//  WeatherBoy
//
//  Created by Pavlo Novak on 2022-03-26.
//

import UIKit

final class APIManager {
    
    let session: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.session = urlSession
    }

    /// Fetch data from API.
    /// - Parameters:
    ///     - api: Accepts object that conforms to APIService protocol.
    ///     - completionHandler: Closure that returns a result value that represents either a success or a failure, including an associated value in each case.
    func fetchCityData(from api: APIService,
                       completionHandler: @escaping (Result<City, Error>) -> Void) {

        guard let request = URL(string: api.requestString) else {
            completionHandler(.failure("Invalid URL"))
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in

            if let error = error {
                completionHandler(.failure(error))
                return
            }

            do {

                guard let data = data else {
                    completionHandler(.failure("Cannot get data."))
                    return
                }

                let city = try JSONDecoder().decode(City.self, from: data)

                DispatchQueue.main.async {
                    completionHandler(.success(city))
                }

            } catch let jsonError {
                completionHandler(.failure(jsonError))
            }
        }.resume()
    }
    
    /// Fetch image from API.
    /// - Parameters:
    ///     - api: Accepts object that conforms to APIService protocol.
    ///     - weatherState: Current state of weather to receive corresponding image
    ///     - completionHandler: Closure that returns a result value that represents either a success or a failure, including an associated value in each case.
    func fetchImageByURL(from api: APIService,
                         weatherState: String,
                         completionHandler: @escaping (Result<UIImage, Error>) -> Void) {
        let weatherStateAppendix = "\(weatherState).png"
        let appendedUrlString = api.requestString.appending(weatherStateAppendix)
        guard let request = URL(string: appendedUrlString) else {
            completionHandler(.failure("Invalid URL"))
            return
        }
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completionHandler(.failure(error))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure("Image data is missing"))
                return
            }
            guard let image = UIImage(data: data) else {
                completionHandler(.failure("Could not convert data into UIImage"))
                return
            }
            
            completionHandler(.success(image))
        }.resume()
    }
}

extension String: Error {}
