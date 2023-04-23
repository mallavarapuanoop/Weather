//
//  ViewModel.swift
//  Weather
//
//  Created by Anoop Mallavarapu on 4/22/23.
//

import Foundation

protocol ViewModelDelegate: AnyObject {
    func updateView(with report: CurrentWeather?, from searchPoint: SearchPoint)
}

class ViewModel {
    
    private let weatherService: WeatherServiceType
    var currentCity: String?
    
    weak var delegate: ViewModelDelegate?
    
    init(weatherService: WeatherServiceType = WeatherService.sharedInstance) {
        self.weatherService = weatherService
    }
    
    func loadWeatherData(for city: String?, searchPoint: SearchPoint) {
        guard let city = city else {
            return
        }
        
        weatherService.loadWeatherData(for: city) { [self] weatherReport in
            guard let weatherReport = weatherReport else {
                delegate?.updateView(with: nil,
                                     from: searchPoint)
                return
            }
            
            saveToFile(report: weatherReport)
            self.delegate?.updateView(with: builData(from: weatherReport),
                                      from: searchPoint)
        }
    }
    
    private func saveToFile(report: WeatherReport) {
        WeatherReport.saveToFile(weatherReport: [report])
    }
    
    func builData(from report: WeatherReport) -> CurrentWeather {
        let code = report.weather?[0].icon ?? ""
        let icon = "https://openweathermap.org/img/wn/\(code)@2x.png"

        return CurrentWeather(cityName: report.name ?? "",
                              currentTemp: "\(report.main?.temp ?? 0)",
                              hTemp: "\(report.main?.temp_max ?? 0)",
                              lTemp: "\(report.main?.temp_min ?? 0)",
                              icon: icon,
                              weatherCondition: report.weather?[0].description ?? "")
    }
}
