//
//  CityCell.swift
//  WeatherBoy
//
//  Created by Pavlo Novak on 2022-03-27.
//

import UIKit

final class CityCell: UITableViewCell {
    
    private struct Constraint {
        static let containerHeightConstraint: CGFloat = 100
        static let containerHorizontalSideConstraint: CGFloat = 24
        static let containerVerticalSideConstraint: CGFloat = 8
        
        static let labelsLeadingConstraint: CGFloat = 16
        static let labelsTopConstraint: CGFloat = 16
    }
    
    override var reuseIdentifier: String? {
        return String(describing: self)
    }
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.backgroundColor = UIColor(red: 111 / 255.0,
                                       green: 190 / 255.0,
                                       blue: 214 / 255.0,
                                       alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 1
        label.textAlignment = .natural
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 1
        label.textAlignment = .natural
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0,
                                     y: 0,
                                     width: UIScreen.main.bounds.width - (Constraint.containerHorizontalSideConstraint * 2),
                                     height: Constraint.containerHeightConstraint)
        gradientLayer.startPoint = CGPoint(x: 0, y: 1)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0)
        gradientLayer.locations = [0.0, 0.5, 1.0]
        gradientLayer.cornerRadius = containerView.layer.cornerRadius
        
        return gradientLayer
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        setupViews()
        applyGradient()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        gradientLayer.setGradientColor(for: traitCollection)
    }
    
    func setup(for cityIndex: Int) {
        let city = MetaWeather.allCases[cityIndex]
        titleLabel.text = city.rawValue
        subtitleLabel.text = city.country()
    }
    
    private func setupViews() {
        labelsStackView.addArrangedSubview(titleLabel)
        labelsStackView.addArrangedSubview(subtitleLabel)
        
        containerView.addSubview(labelsStackView)
        
        contentView.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                   constant: Constraint.containerHorizontalSideConstraint),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                               constant: Constraint.containerVerticalSideConstraint),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                    constant: -Constraint.containerHorizontalSideConstraint),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                                  constant: -Constraint.containerVerticalSideConstraint),
            containerView.heightAnchor.constraint(equalToConstant: Constraint.containerHeightConstraint),
            
            labelsStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,
                                                     constant: Constraint.labelsLeadingConstraint),
            labelsStackView.topAnchor.constraint(equalTo: containerView.topAnchor,
                                                 constant: Constraint.labelsTopConstraint)
        ])
    }
    
    private func applyGradient() {
        gradientLayer.setGradientColor(for: traitCollection)
        containerView.layer.insertSublayer(gradientLayer, at: 0)
    }
}
