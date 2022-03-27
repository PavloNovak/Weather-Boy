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
    
    private lazy var weatherDetailsView: WeatherDetailsView = {
        let view = WeatherDetailsView(with: viewModel)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        return activityIndicator
    }()
    
    init(with cityIndex: Int) {
        self.cityIndex = cityIndex
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = MetaWeather.allCases[cityIndex].rawValue
        
        viewModel.delegate = self
        
        activityIndicator.startAnimating()
        viewModel.fetchCityDataByIndex(cityIndex)
        
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

extension WeatherDetailsViewController: CityViewModelDelegate {
    func didUpdateData() {
        activityIndicator.stopAnimating()
        weatherDetailsView.updateViews()
    }
    
    func didOccurError(withMessage message: String) {
        activityIndicator.stopAnimating()
        // TODO: - Show alert with retry option
    }
}
