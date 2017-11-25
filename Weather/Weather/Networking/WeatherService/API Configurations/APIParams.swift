//
//  APIParams.swift
//  Weather
//
//  Created by Rahul Dubey on 11/24/17.
//  Copyright © 2017 Rahul Dubey. All rights reserved.
//

import Foundation

///MARK: - API's parameters
enum APIParams {
  
  //MARK: - Weather API Keys
  enum Weather: String {
    case apiKey = "{apiKey}"
    case queryString = "{queryString}"
  }
  
  enum WeatherPhoto: String {
    case iconID = "{iconId}"
  }
}
