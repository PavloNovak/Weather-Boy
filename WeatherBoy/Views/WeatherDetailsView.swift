//
//  WeatherDetailsView.swift
//  WeatherBoy
//
//  Created by Pavlo Novak on 1422-03-27.
//

import UIKit

final class WeatherDetailsView: UIStackView {
    
    private let viewModel: CityViewModel
    
    private lazy var weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.numberOfLines = 1
        label.textAlignment = .natural
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var weatherStateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var weatherStateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.numberOfLines = 1
        label.textAlignment = .natural
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var lowTemperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.numberOfLines = 1
        label.textAlignment = .natural
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var highTemperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.numberOfLines = 1
        label.textAlignment = .natural
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var temperatureLabelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var sunriseLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.numberOfLines = 1
        label.textAlignment = .natural
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var sunsetLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.numberOfLines = 1
        label.textAlignment = .natural
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var sunPositionLabelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var localTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.numberOfLines = 1
        label.textAlignment = .natural
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    init(with viewModel: CityViewModel) {
        self.viewModel = viewModel
        
        super.init(frame: .zero)
        
        setupViews()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func updateViews() {
        let weatherArray = viewModel.weather
        // Getting tomorrow's weather
        guard weatherArray.count > 1 else { return }
        let weather = weatherArray[1]
        temperatureLabel.text = "\(Int(weather.currentTemperature))°"
        viewModel.fetchImageByWeatherStateCode(weather.weatherStateCode,
                                               completion: { [weak self] image in
            DispatchQueue.main.async {
                self?.weatherImageView.image = image
            }
        })
        
        weatherStateLabel.text = weather.weatherState
        
        lowTemperatureLabel.text = "L: \(Int(weather.minTemperature))°"
        highTemperatureLabel.text = "H: \(Int(weather.maxTemperature))°"
        
        sunriseLabel.text = "Sunrise: \(viewModel.sunRise.formatToClockString(with: viewModel.timezone))"
        sunsetLabel.text = "Sunset: \(viewModel.sunSet.formatToClockString(with: viewModel.timezone))"
        
        localTimeLabel.text = "Local time: \(viewModel.localTime.formatToClockString(with: viewModel.timezone))"
    }
    
    private func setupViews() {
        
    }
}
