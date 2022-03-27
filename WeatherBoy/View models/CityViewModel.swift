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
    
    public func fetchCityDataByIndex(_ cityIndex: Int) {
        apiManager.fetchCityData(from: MetaWeather.allCases[cityIndex]) { [weak self] result in
            switch result {
            case .success(let city):
                self?.model = city
            case .failure(let error):
                self?.delegate?.didOccurError(withMessage: error.localizedDescription)
                break
            }
        }
    }
    
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
    
    var weather: Weather? {
        guard let weatherModel = model?.weather, weatherModel.count > 1 else { return nil }
        return weatherModel[1]
    }
    
    var sunRise: String {
        return model?.sunRise ?? ""
    }
    
    var sunSet: String {
        return model?.sunSet ?? ""
    }
}
