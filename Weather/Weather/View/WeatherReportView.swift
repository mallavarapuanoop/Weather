//
//  WeatherReportView.swift
//  Weather
//
//  Created by Anoop Mallavarapu on 4/22/23.
//

import UIKit

class WeatherReportView: BaseView {
    
    //MARK: Declare UI views
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
    
    var spacer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var detailsStackview: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.spacing = 8
        stackview.distribution = .fill
        return stackview
    }()
    
    var locationStackview: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.spacing = 8
        stackview.distribution = .fill
        return stackview
    }()
    
    var tempStackview: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.spacing = 16
        stackview.distribution = .fill
        return stackview
    }()
    
    var myLocationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var currentLocationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byTruncatingTail
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var tempLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textColor = .black
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var lowHighTempLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textColor = .black
        label.textAlignment = .right
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: construct/constrain UI
    override func constructSubviewHierarchy() {
        super.constructSubviewHierarchy()
        
        tempStackview.addArrangedSubview(tempLabel)
        tempStackview.addArrangedSubview(lowHighTempLabel)
        
        locationStackview.addArrangedSubview(myLocationLabel)
        locationStackview.addArrangedSubview(currentLocationLabel)
        
        detailsStackview.addArrangedSubview(locationStackview)
        detailsStackview.addArrangedSubview(spacer)
        detailsStackview.addArrangedSubview(tempStackview)
        
        containerview.addSubview(detailsStackview)
        
        self.addSubview(containerview)
    }
    
    override func constructLayout() {
        super.constructLayout()
        
        detailsStackview.pinToEdges(to: containerview,
                                    horizantalPadding: 16,
                                    verticalPadding: 16)
        containerview.pinToEdges(to: self)
    }
    
    //MARK: configure UI
    func configure(with report: CurrentWeather?) {
        guard let report = report else {
            return
        }
        
        currentLocationLabel.text = "My Location"
        myLocationLabel.text = report.cityName
        tempLabel.text = "\(report.currentTemp ?? "")°"
        lowHighTempLabel.text = "H: \(report.hTemp ?? "")°   L: \(report.lTemp ?? "")°"
        layoutIfNeeded()
    }
    
    func updateCurrentLocationLabel(with text: String) {
        currentLocationLabel.text = text
    }
}
