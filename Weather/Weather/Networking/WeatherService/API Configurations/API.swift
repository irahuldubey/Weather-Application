//
//  API.swift
//  Weather
//
//  Created by Rahul Dubey on 11/24/17.
//  Copyright © 2017 Rahul Dubey. All rights reserved.
//

import Foundation

/// API's URL String
struct API {
    
  /// Weather Photo API
  static let weatherIcon = "https://openweathermap.org/img/w/{iconId}.png"
  
  /// Weather Service API
  static let weather  = "https://api.openweathermap.org/data/2.5/weather?q=\(APIParams.Weather.queryString.rawValue)&appid=\(APIParams.Weather.apiKey.rawValue)&mode=json&units=Metric"
}
