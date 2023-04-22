//
//  WeatherService.swift
//  Weather
//
//  Created by Anoop Mallavarapu on 4/21/23.
//

import Foundation

protocol WeatherServiceType: AnyObject {
    func loadWeatherData(for city: String)
}

class WeatherService: WeatherServiceType {
    
    //MARK: Shared instance
    static let sharedInstance = WeatherService()
    
    func loadWeatherData(for city: String) {
        var cityName = replaceSpacesInCityName(city)
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=dbec85b8697521fa091bc41d3a69f1e3&units=imperial"
        let url = URL(string: urlString)
        
        guard let url = url else  { return }
        
        URLSession.shared.dataTask(with: url) { weatherData, resposne, error in
            guard let data = weatherData else { return }
            
            do {
                let decoder = JSONDecoder()
                let weatherReport = try decoder.decode(WeatherReport.self, from: data)

            } catch let error {
                print(error)
            }
        }.resume()
    }
    
    private func replaceSpacesInCityName(_ city: String) -> String {
        var cityName = ""
        let whitespace = NSCharacterSet.whitespaces
        let range = city.rangeOfCharacter(from: whitespace)
        
        if let _ = range {
            cityName = city.replacingOccurrences(of: " ", with: "%20")
        } else {
            cityName = city
        }
        return cityName
    }
}
