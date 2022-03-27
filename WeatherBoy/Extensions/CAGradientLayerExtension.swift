//
//  CAGradientLayerExtension.swift
//  WeatherBoy
//
//  Created by Pavlo Novak on 2022-03-27.
//

import UIKit

extension CAGradientLayer {
    func setGradientColor(for traitCollection: UITraitCollection) {
        if traitCollection.userInterfaceStyle == .dark {
            let color = UIColor.black
            self.colors = [color.withAlphaComponent(0).cgColor,
                                    color.withAlphaComponent(0.3).cgColor,
                                    color.withAlphaComponent(0.5).cgColor]
        } else {
            let color = UIColor.white
            self.colors = [color.withAlphaComponent(0).cgColor,
                                    color.withAlphaComponent(0.3).cgColor,
                                    color.withAlphaComponent(0.5).cgColor]
        }
    }
}
