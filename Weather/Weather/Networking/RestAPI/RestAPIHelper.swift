//
//  RestAPIHelper.swift
//  Weather
//
//  Created by Rahul Dubey on 11/24/17.
//  Copyright © 2017 Rahul Dubey. All rights reserved.
//

import Foundation

/// Rest API Helper for parsing
struct RestAPIHelper {
  
  /// Get Weather API URL String
  ///
  /// - Parameters:
  ///   - city: is of type String  City Name Searched For
  ///   - appID: is of type String APP ID
  /// - Returns: is of type String, Return the complete URL String
  
  static func getWeatherAPIURL(with city: String, appID: String) -> String {
    let urlWithQueryString = API.weather.replacingOccurrences(of: APIParams.Weather.queryString.rawValue, with: "\(city)")
    let urlWithAppId = urlWithQueryString.replacingOccurrences(of: APIParams.Weather.apiKey.rawValue, with: "\(appID)")
    ///Add to logger API
    print("RestAPIHelper: Function: getWeatherAPIURL - URL for weather details \(urlWithAppId)")
    return urlWithAppId
  }
  
  static func getWeatherIconPhoto(with iconId: String) -> String {
    let iconIdString = API.weatherIcon.replacingOccurrences(of: APIParams.WeatherPhoto.iconID.rawValue, with: "\(iconId)")
    ///Add to logger API
    print("RestAPIHelper: Function: getWeatherIconPhoto - URL for Photo URL \(iconIdString)")
    return iconIdString
  }
}
