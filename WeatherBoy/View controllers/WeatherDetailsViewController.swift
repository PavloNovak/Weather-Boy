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
        let weatherView = WeatherDetailsView(with: viewModel)
        weatherView.axis = .vertical
        weatherView.alignment = .center
        weatherView.spacing = 16
        weatherView.translatesAutoresizingMaskIntoConstraints = false
        
        return weatherView
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
        
        view.backgroundColor = .systemBackground
        navigationItem.title = MetaWeather.allCases[cityIndex].rawValue
        
        viewModel.delegate = self
        
        activityIndicator.startAnimating()
        viewModel.fetchCityDataByIndex(cityIndex)
        
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(activityIndicator)
        view.addSubview(weatherDetailsView)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            weatherDetailsView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            weatherDetailsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                                    constant: 32),
            weatherDetailsView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
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
