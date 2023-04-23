//
//  ViewModel.swift
//  Weather
//
//  Created by Anoop Mallavarapu on 4/22/23.
//

import Foundation

protocol ViewModelDelegate: AnyObject {
    func updateView(with report: WeatherReport)
}

class ViewModel {
    
    private let weatherService: WeatherServiceType
    var currentCity: String?
    
    weak var delegate: ViewModelDelegate?
    
    init(weatherService: WeatherServiceType = WeatherService.sharedInstance) {
        self.weatherService = weatherService
    }
    
    var testReport: WeatherReport?
    
    func loadCurrentLocationData() {
        guard let city = currentCity else {
            return
        }
        
        weatherService.loadWeatherData(for: city) { [self] testReport in
            self.testReport = testReport
            guard let testReport = testReport else { return }
            self.delegate?.updateView(with: testReport)
        }
    }
}
