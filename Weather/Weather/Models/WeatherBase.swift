//
//  File.swift
//  Weather
//
//  Created by Rahul Dubey on 11/24/17.
//  Copyright © 2017 Rahul Dubey. All rights reserved.
//

import Foundation

/// Struct Description: WeatherBase - It is a bse object which holds all the parameters of the weather to be shared across different controllers
public struct WeatherBase {
  
  //MARK: Properties
  
  /// is of type Coordinate, Coordinate detail object
  var coordinate: Coordinate?
  /// is of type Weather, Weather Object
  var weather: Weather?
  /// is of type Wind, Wind Object
  var wind: Wind?
  /// is of type Systems Details, System Details Object
  var systemDetail: SystemDetails?
  /// is of type WeatherMainDetails, WeatherMainDetailsObject
  var mainDetail: WeatherMainDetails?
  /// is of type String, Weather Current Station
  var base: String?
  /// is of type Int, Visibility, meter
  var visibility: Int?
  /// is of type Dictionary: Keys is String and value is Int
  var clouds: Dictionary<String, Int>?
  /// is of type Int, Time of data calculation, unix, UTC
  var dt: Int?
  /// is of type String, City ID
  var id: Int?
  /// is of type String, City name
  var name: String?
  
  /// Initializer of Weather Base
  ///
  /// - Parameters:
  ///   - coordinate: is of type coordinate, Geolocation: latitude and longitude
  ///   - weather: is of type weather, weather details
  ///   - wind: is of type wind, wind speed and degree
  ///   - systemDetails: is of type system details, returns the internal parameters
  ///   - mainDetails: is of type main details, returns the main details of the weather
  ///   - base: is of type String, current station
  ///   - visibility: is of type Int, visibility in meters
  ///   - cloud: is of type Dictionary, returns the cloud id
  ///   - dt: is of type Int, returns the time of data calculation
  ///   - id: is of type String, returns the id of the city
  ///   - name: is of type String, returns the name of the city
  init(with coordinate: Coordinate?, weather: Weather?, wind: Wind?, systemDetails: SystemDetails?,
       mainDetails: WeatherMainDetails?, base: String?, visibility: Int?, clouds: Dictionary<String, Int>?,
       dt: Int?, id: Int?, name: String?) {
    
    self.coordinate = coordinate
    self.weather = weather
    self.wind = wind
    self.systemDetail = systemDetails
    self.mainDetail = mainDetails
    self.base = base
    self.visibility = visibility
    self.clouds = clouds
    self.dt = dt
    self.id = id
    self.name = name
  }
}
