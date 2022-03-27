//
//  WeatherDetailsViewController.swift
//  WeatherBoy
//
//  Created by Pavlo Novak on 2022-03-26.
//

import Foundation
import UIKit

class WeatherDetailsViewController: UIViewController {
    
    private let cityIndex: Int
    private let viewModel: CityViewModel = CityViewModel()
    
    init(with cityIndex: Int) {
        self.cityIndex = cityIndex
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        
        // TODO: - Show loader
        viewModel.fetchCityDataByIndex(cityIndex)
    }
}

extension WeatherDetailsViewController: CityViewModelDelegate {
    func didUpdateData() {
        // TODO: - Stop loader
        // TODO: - Update screen
    }
    
    func didOccurError(withMessage message: String) {
        // TODO: - Stop loader
        // TODO: - Show alert with retry option
    }
}
