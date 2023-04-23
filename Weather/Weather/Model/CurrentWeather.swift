//
//  CurrentWeather.swift
//  Weather
//
//  Created by Anoop Mallavarapu on 4/23/23.
//

import Foundation

struct CurrentWeather {
    let cityName: String?
    let currentTemp: String?
    let hTemp: String?
    let lTemp: String?
    let icon: String?
    let weatherCondition: String?
    let islastViewed: Bool?
    
    init(cityName: String?, currentTemp: String?, hTemp: String?, lTemp: String?, icon: String? = nil, weatherCondition: String? = nil, islastViewed: Bool? = false) {
        self.cityName = cityName
        self.currentTemp = currentTemp
        self.hTemp = hTemp
        self.lTemp = lTemp
        self.icon = icon
        self.weatherCondition = weatherCondition
        self.islastViewed = islastViewed
    }
}
