//
//  WeatherReport.swift
//  Weather
//
//  Created by Anoop Mallavarapu on 4/21/23.
//

import UIKit
import Foundation

struct WeatherReport: Codable {
    var coord: Coordinates?
    var weather: [Weather]?
    var base: String?
    var main: Temperature?
    var visibility: Double?
    var wind: WindReport?
    var rain: RainReport?
    var clouds: Clouds?
    var dt: Double?
    var sys: SunriseData?
    var timezone: Double?
    var id: Double?
    var name: String?
    var cod: Double?
    
    
    static let docDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let archiveURL = docDirectory.appending(path: "Weather").appendingPathExtension("plist")
    
    
    static func saveToFile(weatherReport: [WeatherReport]) {
        let encoder = PropertyListEncoder()
        
        let codedReport = try? encoder.encode(weatherReport)
        try? codedReport?.write(to: archiveURL, options: .noFileProtection)
    }
    
    static func loadFromFile() -> [WeatherReport]? {
        guard let codedReport = try? Data(contentsOf: archiveURL) else { return nil}
        let decoder = PropertyListDecoder()
        
        return try? decoder.decode(Array<WeatherReport>.self, from: codedReport)
    }
}

struct Coordinates: Codable {
    var lon: Double?
    var lat: Double?
}

struct Weather: Codable {
    var id: Double?
    var main: String?
    var description: String?
    var icon: String?
}

struct Temperature: Codable {
    var temp: Double?
    var feels_like: Double?
    var temp_min: Double?
    var temp_max: Double?
    var pressure: Double?
    var humidity: Double?
}

struct WindReport: Codable {
    var speed: Double?
    var deg: Double?
    var gust: Double?
}

struct RainReport: Codable {
    enum CodingKeys: String, CodingKey {
       case oneH = "1h"
     }
    
    var oneH: Double?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.oneH = try container.decode(Double.self, forKey: .oneH)
      }
}

struct Clouds: Codable {
    var all: Double?
}

struct SunriseData: Codable {
    var type: Double?
    var id: Double?
    var country: String?
    var sunrise: Double?
    var sunset: Double?
}
