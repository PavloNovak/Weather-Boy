//
//  ApplicationController.swift
//  WeatherBoy
//
//  Created by Pavlo Novak on 2022-03-27.
//

import Foundation
import UIKit

final class ApplicationController {
    let rootViewController: UINavigationController
    
    init(with rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
        self.rootViewController.navigationItem.title = "Weather"
    }
    
    func setup() {
        let weatherViewController = CitiesViewController()
        weatherViewController.didSelectCity = { [weak rootViewController] cityIndex in
            let cityDetailsViewController = WeatherDetailsViewController(with: cityIndex)
            rootViewController?.pushViewController(cityDetailsViewController, animated: true)
        }
        rootViewController.setViewControllers([weatherViewController], animated: false)
    }
}
