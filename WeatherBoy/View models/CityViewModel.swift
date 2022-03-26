//
//  CityViewModel.swift
//  WeatherBoy
//
//  Created by Pavlo Novak on 2022-03-26.
//

import Foundation

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
}