//
//  WeatherForecastViewModel.swift
//  Weather
//
//  Created by Rahul Dubey on 11/24/17.
//  Copyright © 2017 Rahul Dubey. All rights reserved.
//

import Foundation

//MARK: - WeatherService Response
public enum WeatherServiceStatus {
  ///Success Response from the Weather Search Service
  case success
  ///Failure Response from the Weather Search Service
  case failure
}

/// Class Description: WeatherForecastViewModel binded to WeatherForecastViewController for data binding (Presentation Logic) and network calls
public final class WeatherForecastViewModel {
  
  //MARK: - Binded Properties
  
  ///Sucess Binded Text
  public private(set) var temperature: String?
  public private(set) var forecastType: String?
  public private(set) var cityName: String?
  public private(set) var iconID: String?
  public private(set) var minimumTemperature: String?
  public private(set) var maximumTemperature: String?
  public private(set) var windSpeed: String?
  public private(set) var humidity: String?
  public private(set) var pressure: String?
  public private(set) var visibility: String?
  public private(set) var sunrise: String?
  public private(set) var sunset: String?
  
  ///Failure Binded Text
  public private(set) var errorText: String?

  ///Weather Service Protocol to call the Weather Service API
  let weatherService: WeatherServiceAPI = WeatherService()
  
  //MARK: - Initializer
  init() { }
  
  /// Fetch the Weather Details from Weather API, As of now this API fetch the data in Degree Celcius, later on this can be modified to add an additional Enumeration as Parameter to supply the type as requested from the user, User can also switch between the Celcius and Fahrenheit if the service call has already been made we just to do the transformation from Celsius to Fahrenheit but we can also configure our Application from settings to default the service type requested Celcius or Fahrenheit
  
  ///
  /// - Parameter query: as of Type String, City Name Searched
  ///- TODO: Add Celcius/Fahrenheit later and any additional parameters as requested.
  func fetchWeatherDetails(for cityName: String, withCompletionHandler completion: @escaping (WeatherServiceStatus) -> ()){
    do {
      try weatherService.fetchWeather(for: cityName) { [weak self] (wsResponse) in
        guard let `self` = self else { return }
        switch wsResponse {
        case .success(weather: let weatherObj):
          guard let weatherObject = weatherObj else {
            ///Add to Logger Info
            print("WeatherForecastViewModel: Function : fetchWeatherDetails - WeatherObject is nil")
            return
          }
          self.setUpViewModelData(weatherObj: weatherObject)
          completion(.success)
        case .failure(error: let weatherServiceError):
          ///Return the FAILURE to the view controller,
          ///Add to Logger Info
          print("WeatherForecastViewModel: Function: fetchWeatherDetails, Error received from the Weather Service \(String(describing: weatherServiceError))")
          self.errorText = weatherServiceError?.displayError
          completion(.failure)
        }
      }
    } catch let error {
      ///Add to Logger Info
      print("WeatherForecastViewModel: Function: fetchWeatherDetails, Error received from the Weather Service \(error)")
    }
  }
  
  /// Set Up View Model Properties
  ///
  /// - Parameter weatherObj: Weather Object
  private func setUpViewModelData(weatherObj: WeatherBase) {
    let temperature = weatherObj.mainDetail?.temperature
    self.temperature = temperature?.toString().appending(PlaceHolders.degreeCelciusString)
    self.humidity = weatherObj.mainDetail?.humidity.toString().appending(PlaceHolders.percentageString)
    self.pressure = weatherObj.mainDetail?.pressure.toString().appending(PlaceHolders.pressureUnit)
    self.minimumTemperature = weatherObj.mainDetail?.minimumTemperature.toString().appending(PlaceHolders.degreeCelciusString)
    self.maximumTemperature = weatherObj.mainDetail?.maximumTemperature.toString().appending(PlaceHolders.degreeCelciusString)
    self.windSpeed = weatherObj.wind?.speed.toString().appending(PlaceHolders.windDegree)
    self.visibility = weatherObj.visibility?.toString().appending(PlaceHolders.metres)
    self.forecastType = weatherObj.weather?.description.capitalized
    self.cityName = weatherObj.name?.capitalized
    self.iconID = weatherObj.weather?.icon
  }
  
  //MARK - Deinitializer
  deinit {
    ///Add to Logger Info
    print("Deinitialized Search Result View Model")
  }
}
