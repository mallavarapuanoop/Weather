//
//  ViewController.swift
//  Weather
//
//  Created by Anoop Mallavarapu on 4/20/23.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    //UI Elements
    
    lazy var detailsStack: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.spacing = 16
        stackview.distribution = .fill
        return stackview
    }()
    
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
    
    lazy var searchField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.autocorrectionType = UITextAutocorrectionType.yes
        textField.keyboardType = UIKeyboardType.alphabet
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        textField.attributedPlaceholder = NSAttributedString(
            string: "Enter city name",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        return textField
    }()
    
    lazy var weatherReportView: WeatherReportView = {
        let weatherReportView = WeatherReportView()
        weatherReportView.translatesAutoresizingMaskIntoConstraints = false
        weatherReportView.isHidden = true
        return weatherReportView
    }()
    
    //Initialization
    var locationManager = CLLocationManager()
    let viewModel = ViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        isLocationAccessEnabled()
        setupUI()
        setupConstraints()
        searchField.delegate = self
        viewModel.delegate = self
    }
    
    func isLocationAccessEnabled() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager.delegate = self
                self.locationManager.requestLocation()
                self.locationManager.requestAlwaysAuthorization()
            }
        }
        
        DispatchQueue.global().async {
            if !CLLocationManager.locationServicesEnabled() {
                self.locationManager.requestAlwaysAuthorization()
                self.locationManager.requestWhenInUseAuthorization()
            }
        }
    }
    
    private func setupUI() {
        
        containerview.addSubview(searchField)
        
        detailsStack.addArrangedSubview(containerview)
        
        detailsStack.addArrangedSubview(weatherReportView)
        
        self.view.backgroundColor = .white
        self.view.addSubview(detailsStack)
    }
    
    private func setupConstraints() {
        searchField.pinToEdges(to: containerview)
        
        NSLayoutConstraint.activate([
            searchField.heightAnchor.constraint(equalToConstant: 50),
            
            detailsStack.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            detailsStack.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,
                                                 constant: 24),
            detailsStack.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,
                                                  constant: -24)
        ])
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let city = textField.text {
            
        }
        textField.resignFirstResponder()
        return true
    }
}

extension ViewController: CLLocationManagerDelegate {
    //MARK: - location delegate methods
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation :CLLocation = locations[0] as CLLocation
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(userLocation) { (placemarks, error) in
            if (error != nil) {
                print("error in reverseGeocode")
            }
            
            guard let placemarks = placemarks,
                  let placemark = placemarks.first,
                  let locality = placemark.locality else { return }
            
            print("Testing locality:", locality)
            
            self.viewModel.currentCity = locality
            self.viewModel.loadCurrentLocationData()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
        // if the location access is turned off by user add an alert to request for location access again
    }
}

extension ViewController: ViewModelDelegate {
    func updateView(with report: WeatherReport) {
        let currreport: CurrentWeather = CurrentWeather(cityName: report.name ?? "",
                                                        currentTemp: "\(report.main?.temp ?? 0)",
                                            hTemp: "\(report.main?.temp_max ?? 0)",
                                            lTemp: "\(report.main?.temp_min ?? 0)",
                                                        icon: report.weather?[0].icon)
        DispatchQueue.main.async {
            self.weatherReportView.configure(with: currreport)
            self.weatherReportView.isHidden = false
        }
    }
}


struct CurrentWeather {
    let cityName: String?
    let currentTemp: String?
    let hTemp: String?
    let lTemp: String?
    let icon: String?
}
