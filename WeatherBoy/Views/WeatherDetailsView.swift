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
        label.font = .systemFont(ofSize: 48, weight: .semibold)
        label.numberOfLines = 1
        label.textAlignment = .natural
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var weatherStateStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var weatherStateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 1
        label.textAlignment = .natural
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var lowTemperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 1
        label.textAlignment = .natural
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var highTemperatureLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 1
        label.textAlignment = .natural
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var temperatureLabelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var sunriseLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 1
        label.textAlignment = .natural
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var sunsetLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
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
        label.font = .systemFont(ofSize: 20, weight: .semibold)
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
        let weather = viewModel.weatherForTomorrow
        guard let weather = weather else { return }
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
}

extension WeatherDetailsView {
    private func setupViews() {
        weatherStateStackView.addArrangedSubview(weatherImageView)
        weatherStateStackView.addArrangedSubview(temperatureLabel)
        addArrangedSubview(weatherStateStackView)
        
        addArrangedSubview(weatherStateLabel)
        
        temperatureLabelsStackView.addArrangedSubview(lowTemperatureLabel)
        temperatureLabelsStackView.addArrangedSubview(highTemperatureLabel)
        addArrangedSubview(temperatureLabelsStackView)
        
        sunPositionLabelsStackView.addArrangedSubview(sunriseLabel)
        sunPositionLabelsStackView.addArrangedSubview(sunsetLabel)
        addArrangedSubview(temperatureLabelsStackView)
        
        addArrangedSubview(localTimeLabel)
        
        NSLayoutConstraint.activate([
            weatherImageView.heightAnchor.constraint(equalToConstant: 64),
            weatherImageView.widthAnchor.constraint(equalTo: weatherImageView.heightAnchor)
        ])
    }
}
