//
//  APIResponseKeys.swift
//  Weather
//
//  Created by Rahul Dubey on 11/24/17.
//  Copyright © 2017 Rahul Dubey. All rights reserved.
//

/// APIResponseKeys for the all the webservice calls
enum APIResponseKeys {

  //MARK: - Weather API Response Keys
  enum weather: String {
    case coordinate = "coord"
    case latitude = "lat"
    case longitude = "lon"
    
    case weather
    case id
    case main
    case description
    case icon
    case base

    case temperature = "temp"
    case pressure
    case humidity
    case minTemp = "temp_min"
    case maxTemp = "temp_max"
    case visibility
    
    case clouds
    case all
    case dt
    case message
    case country
    case wind
    case speed
    case degree = "deg"
    case system = "sys"
    case type
    case sunrise
    case sunset
    case name
    case cod = "cod"
  }
}


