//
//  WeatherServiceAPI.swift
//  Weather
//
//  Created by Rahul Dubey on 11/24/17.
//  Copyright © 2017 Rahul Dubey. All rights reserved.
//

import Foundation

///Weather Service API Protocol will be implemented by the Weather Service API
protocol WeatherServiceAPI {
  
  /// Fetch Weather Details from the Weather Service ORG.
  ///
  /// - Parameters:
  ///   - city: City Queried
  ///   - completion: Completion Handler return Error and Sucess
  /// - Throws: Throws Void
  func fetchWeather(for city: String, withCompletionHandler completion: @escaping (WeatherServiceResponse) -> ()) throws -> Void
  
  
  /// WeatherService Photo
  ///
  /// - Parameters:
  ///   - url: is of type String, URL for the image logo
  ///   - completion: completionHandler Returns Data and Error
  /// - Returns: Void
  /// - Throws: throws Void
  func fetchWeatherPhoto(for url: String, withCompletionHandler completion: @escaping (WeatherImageResponse) -> ()) throws -> Void
}
