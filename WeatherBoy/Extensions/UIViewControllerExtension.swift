//
//  UIViewControllerExtension.swift
//  WeatherBoy
//
//  Created by Pavlo Novak on 2022-03-27.
//

import UIKit

extension UIViewController {
    func presentAlert(title: String, message: String, actions: [UIAlertAction]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach { action in
            alert.addAction(action)
        }
        self.present(alert, animated: true, completion: nil)
    }
}
