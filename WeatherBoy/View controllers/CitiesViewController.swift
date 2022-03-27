//
//  CitiesViewController.swift
//  WeatherBoy
//
//  Created by Pavlo Novak on 2022-03-26.
//

import UIKit

class CitiesViewController: UIViewController {
    
    public var didSelectCity: ((Int) -> Void)?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "basicStyle")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        tableView.reloadData()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension CitiesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MetaWeather.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicStyle", for: indexPath)
        assert(indexPath.row < MetaWeather.allCases.count,
               "TableView should not have more rows than cases in MetaWeather enumeration")
        cell.textLabel?.text = MetaWeather.allCases[indexPath.row].rawValue
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectCity?(indexPath.row)
    }
}
