//
//  WeatherDetailsView.swift
//  Weather
//
//  Created by Anoop Mallavarapu on 4/23/23.
//

import UIKit
import Foundation

class WeatherDetailsView: BaseView {
    var containerview: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 3
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowRadius = 3
        view.layer.shadowOpacity = 1.0
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var lastViewedLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.text = "Recently Viewed"
        label.textColor = .black
        label.textAlignment = .left
        label.isHidden = true
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.startAnimating()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    var detailsStackview: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.spacing = 8
        stackview.distribution = .fill
        return stackview
    }()
    
    var locationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var tempLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 50)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var weatherConditionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var highLowTempLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var imageview: UIImageView = {
        let imageview = UIImageView()
        imageview.contentMode = .scaleAspectFill
        imageview.translatesAutoresizingMaskIntoConstraints = false
        return imageview
    }()
    
    override func constructSubviewHierarchy() {
        super.constructSubviewHierarchy()
        containerview.addSubview(imageview)
        
        detailsStackview.addArrangedSubview(lastViewedLabel)
        detailsStackview.addArrangedSubview(locationLabel)
        detailsStackview.addArrangedSubview(tempLabel)
        detailsStackview.addArrangedSubview(weatherConditionLabel)
        detailsStackview.addArrangedSubview(highLowTempLabel)
        
        containerview.addSubview(detailsStackview)
        containerview.addSubview(spinner)
        
        
        self.addSubview(containerview)
    }
    
    override func constructLayout() {
        super.constructLayout()
        
        spinner.pinToCenter(to: containerview, size: 16)
        
        detailsStackview.pinToEdges(to: containerview,
                                    horizantalPadding: 16,
                                    verticalPadding: 16)
        
        imageview.pinToEdges(to: containerview,
                             horizantalPadding: 16,
                             verticalPadding: 16)
        
        containerview.pinToEdges(to: self)
    }
    
    func configure(with report: CurrentWeather) {
        locationLabel.text = report.cityName
        tempLabel.text = "\(report.currentTemp ?? "")°"
        weatherConditionLabel.text = "\(report.weatherCondition ?? "")"
        highLowTempLabel.text = "H: \(report.hTemp ?? "")°   L: \(report.lTemp ?? "")°"
        
        lastViewedLabel.isHidden = !(report.islastViewed ?? false)
        
        spinner.stopAnimating()
        if let icon = report.icon {
            imageview.loadImageUsingCache(withUrl: icon)
        }
        layoutIfNeeded()
    }
}
