//
//  CityViewModel.swift
//  WeatherBoy
//
//  Created by Pavlo Novak on 2022-03-26.
//

import UIKit

final class CityViewModel {
    
    public weak var delegate: CityViewModelDelegate?
    
    private let apiManager: APIManager
    private var model: City? {
        didSet {
            delegate?.didUpdateData()
        }
    }
    
    init(apiManager: APIManager = APIManager(), model: City? = nil) {
        self.apiManager = apiManager
        self.model = model
    }
    
    /// Fetches data from API by city index
    /// - Parameter cityIndex: Selected city index
    public func fetchCityDataByIndex(_ cityIndex: Int) {
        apiManager.fetchCityData(from: CityEnumeration.allCases[cityIndex]) { [weak self] result in
            switch result {
            case .success(let city):
                self?.model = city
            case .failure(let error):
                self?.delegate?.didOccurError(withMessage: error.localizedDescription)
                break
            }
        }
    }
    
    /// Fetches image from API to represent corresponding weather
    /// - Parameters:
    ///   - code: Weather state code
    ///   - completion: Closure that returns a result value that represents either a success or a failure, including an associated value in each case.
    public func fetchImageByWeatherStateCode(_ code: String, completion: @escaping ((UIImage) -> Void)) {
        apiManager.fetchImageByURL(from: MetaWeatherState.image,
                                   weatherState: code) { result in
            switch result {
            case .success(let image):
                completion(image)
            case .failure(_):
                break
            }
        }
    }

}

extension CityViewModel: CityViewModelRepresentable {
    var title: String {
        return model?.title ?? ""
    }
    
    var weather: [Weather] {
        return model?.weather ?? []
    }
    
    var localTime: String {
        return model?.localTime ?? ""
    }
    
    var sunRise: String {
        return model?.sunRise ?? ""
    }
    
    var sunSet: String {
        return model?.sunSet ?? ""
    }
    
    var timezone: String {
        return model?.timeZoneIdentifier ?? ""
    }
}

extension CityViewModel {
    var weatherForTomorrow: Weather? {
        guard let model = model, model.weather.count > 1 else { return nil }
        
        return model.weather[1]
    }
}
