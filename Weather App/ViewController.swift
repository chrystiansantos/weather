//
//  ViewController.swift
//  Weather App
//
//  Created by chrystiansantos.dev on 31/10/24.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var backgroundView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
       return imageView
    }()
    
    private lazy var headerView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        label.textColor = UIColor.primaryColor
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 70, weight: .bold)
        label.textAlignment = .left
        label.textColor = UIColor.primaryColor
        label.translatesAutoresizingMaskIntoConstraints = false
            
        return label
    }()
    
    private lazy var weatherIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.sunerIcon
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var humidityLabel: UILabel = {
        let label = UILabel()
        label.text = "Umidade"
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textColor = UIColor.contrastColor
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var humidityValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textColor = UIColor.contrastColor
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var windStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            humidityLabel,
            humidityValueLabel
        ])
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var windLabel: UILabel = {
        let label = UILabel()
        label.text = "Vento"
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textColor = UIColor.contrastColor
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var windValueLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textColor = UIColor.contrastColor
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var humidityStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            windLabel,
            windValueLabel
        ])
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var statsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            humidityStackView,
            windStackView
        ])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 4
        stackView.backgroundColor = UIColor.lightGray
        stackView.layer.cornerRadius = 10
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 12, leading: 24, bottom: 12, trailing: 24)
        
        return stackView
    }()
    
    private lazy var hourlyForecastLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.contrastColor
        label.text = "Previsão por hora".uppercased()
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var hourlyCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 67, height: 84)
        layout.sectionInset = UIEdgeInsets(top: .zero, left: 12, bottom: .zero, right: 12)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.register(HourlyForecastCollectionViewCell.self, forCellWithReuseIdentifier: HourlyForecastCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView;
    }()
    
    private lazy var dailyForecastLabel:UILabel = {
        let label = UILabel()
        label.textColor = UIColor.contrastColor
        label.text = "Próximos dias".uppercased()
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var dailyForecastTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(DailyForecastTableViewCell.self, forCellReuseIdentifier: DailyForecastTableViewCell.identifier)
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    private let service = Service()
    private var city = City(lat: "-20.183825", lon: "-45.707164", name: "Iguatama")
    private var forecastResponse: ForecastResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchData()
    }
    
    private func fetchData(){
        service.fetchData(city: city){ [weak self] response in
            self?.forecastResponse = response
            DispatchQueue.main.async{
                self?.loadData()
            }
        }
    }
                          
    private func loadData(){
        cityLabel.text = city.name
        temperatureLabel.text = forecastResponse?.current.temp.toCelsius()
        humidityValueLabel.text = "\((forecastResponse?.current.humidity ?? 0))mm"
        windValueLabel.text = "\(Int(forecastResponse?.current.windSpeed ?? 0))km/h"
        weatherIcon.image = UIImage(named: forecastResponse?.current.weather.first?.icon ?? "")

        if(forecastResponse?.current.dt.isDayTime() ?? true){
            backgroundView.image = UIImage(named: "background-day")
        }else {
            backgroundView.image = UIImage(named: "background-night")
        }
        
        hourlyCollectionView.reloadData()
        dailyForecastTableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    private func setupView(){
        view.backgroundColor = .white
        setHierarchy()
        setConstraints()
    }

    private func setHierarchy(){
        view.addSubview(backgroundView)
        view.addSubview(headerView)
        view.addSubview(statsStackView)
        view.addSubview(hourlyForecastLabel)
        view.addSubview(hourlyCollectionView)
        view.addSubview(dailyForecastLabel)
        view.addSubview(dailyForecastTableView)
        
        headerView.addSubview(cityLabel)
        headerView.addSubview(temperatureLabel)
        headerView.addSubview(weatherIcon)
    }
    
    private func setConstraints(){
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            headerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 35),
            headerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -35),
            headerView.heightAnchor.constraint(equalToConstant: 169)
        ])
        
        NSLayoutConstraint.activate([
            cityLabel.topAnchor.constraint(equalTo: headerView.topAnchor, constant: 15),
            cityLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 15),
            cityLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -15),
            cityLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            temperatureLabel.heightAnchor.constraint(equalToConstant: 71),
            temperatureLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 12),
            temperatureLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 18),
        ])
        
        NSLayoutConstraint.activate([
            weatherIcon.heightAnchor.constraint(equalToConstant: 86),
            weatherIcon.widthAnchor.constraint(equalToConstant: 86),
            weatherIcon.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -18),
            weatherIcon.centerYAnchor.constraint(equalTo: temperatureLabel.centerYAnchor),
            weatherIcon.leadingAnchor.constraint(equalTo: temperatureLabel.trailingAnchor, constant: 8)
        ])
        
        NSLayoutConstraint.activate([
            statsStackView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 24),
            statsStackView.widthAnchor.constraint(equalToConstant: 206),
            statsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            hourlyForecastLabel.topAnchor.constraint(equalTo: statsStackView.bottomAnchor, constant: 30),
            hourlyForecastLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            hourlyForecastLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35)
        ])
        
        NSLayoutConstraint.activate([
            hourlyCollectionView.topAnchor.constraint(equalTo: hourlyForecastLabel.bottomAnchor, constant: 22),
            hourlyCollectionView.heightAnchor.constraint(equalToConstant: 84),
            hourlyCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hourlyCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            dailyForecastLabel.topAnchor.constraint(equalTo: hourlyCollectionView.bottomAnchor, constant: 29),
            dailyForecastLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 35),
            dailyForecastLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -35)
        ])
        
        NSLayoutConstraint.activate([
            dailyForecastTableView.topAnchor.constraint(equalTo: dailyForecastLabel.bottomAnchor, constant: 16),
            dailyForecastTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dailyForecastTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dailyForecastTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecastResponse?.hourly.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyForecastCollectionViewCell.identifier, for: indexPath) as? HourlyForecastCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let forecast = forecastResponse?.hourly[indexPath.row]
        
        cell.loadData(
            time: forecast?.dt.toHourFormat(),
            icon: UIImage(named: forecast?.weather.first?.icon ?? ""),
            temp: forecast?.temp.toCelsius())
        
        return cell
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecastResponse?.daily.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DailyForecastTableViewCell.identifier, for: indexPath) as? DailyForecastTableViewCell else {
            return UITableViewCell()
        }
        let forecast = forecastResponse?.daily[indexPath.row]
        
        
        cell.loadData(
            weekDay: forecast?.dt.toWeekdayName().uppercased(),
            min: forecast?.temp.min.toCelsius(),
            max: forecast?.temp.max.toCelsius(),
            icon: UIImage(named: forecast?.weather.first?.icon ?? ""))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }

}
