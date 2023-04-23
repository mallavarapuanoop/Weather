//
//  ViewModelTests.swift
//  WeatherTests
//
//  Created by Anoop Mallavarapu on 4/23/23.
//

import XCTest
@testable import Weather

final class ViewModelTests: XCTestCase {
    
    var mockService: MockWeatherService!
    var viewmodel: ViewModel!
    
    
    override func setUp() {
        mockService = MockWeatherService()
        viewmodel = ViewModel(weatherService: mockService)
    }
    
    func test_UpdatedUIGetsCalledWhenWeatherReportResponseHasData() {
        mockService.mockData = testData
        XCTAssertNil(viewmodel.weatherReport)
        
        
        viewmodel.loadWeatherData(for: "Cincinnati", searchPoint: .searchBar)
        XCTAssertNotNil(viewmodel.weatherReport)
    }
    
    func test_buildDataGivesYouCurrentWeather() {
        let data = viewmodel.builData(from: testData)
        
        XCTAssertNotNil(data.icon)
    }
    
    private var testData: WeatherReport {
        
        return WeatherReport(coord: nil,
                             weather: [Weather(id: 100,
                                               main: "Clouds",
                                               description: "Scattered clouds",
                                               icon: "03d")],
                             base: nil,
                             main: Temperature(temp: 79.11, feels_like: nil, temp_min: 87.9, temp_max: 100.0),
                             visibility: nil,
                             wind: nil,
                             rain: nil,
                             clouds: nil,
                             dt: nil,
                             sys: nil,
                             timezone: nil,
                             id: nil,
                             name: "Cincinnati",
                             cod: nil)
    }

}

class MockWeatherService: WeatherServiceType {
    var mockData: WeatherReport?
    
    func loadWeatherData(for city: String, completion: @escaping (WeatherReport?) -> Void) {
        completion(mockData)
    }
}
