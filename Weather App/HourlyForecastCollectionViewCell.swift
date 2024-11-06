//
//  HourlyForecastCollectionViewCell.swift
//  Weather App
//
//  Created by chrystiansantos.dev on 03/11/24.
//

import UIKit

class HourlyForecastCollectionViewCell: UICollectionViewCell {
    
    static let identifier : String = "HourlyForecast"
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            hourLabel,
            iconImageView,
            temperatureLabel
        ])
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.layer.borderWidth = 1
        stackView.layer.borderColor = UIColor.contrastColor?.cgColor
        stackView.layer.cornerRadius = 20
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private lazy var hourLabel: UILabel = {
        let label = UILabel()
        label.text = "13:00"
        label.textColor = UIColor(named: "contrastColor")
        label.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "25°C"
        label.textColor = UIColor.contrastColor
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.sunerIcon
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){
        setHierachy()
        setConstraints()
    }
    
    private func setHierachy(){
        contentView.addSubview(stackView)
    }
    
    private func setConstraints(){
        stackView.setContraintsToParent(contentView)
        
        NSLayoutConstraint.activate([
            iconImageView.heightAnchor.constraint(equalToConstant: 33)
        ])
        
    }
}
