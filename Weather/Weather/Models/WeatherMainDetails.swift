//
//  WeatherMainDetails.swift
//  Weather
//
//  Created by Rahul Dubey on 11/24/17.
//  Copyright © 2017 Rahul Dubey. All rights reserved.
//

import Foundation

/// Struct Description: Weather Main Details of the searched weather location
struct WeatherMainDetails {
  
  //MARK: - Properties
  
  /// is of type Double, Temperature. Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.
  let temperature: Double
  /// is of type Double, Atmospheric pressure (on the sea level, if there is no sea_level or grnd_level data), hPa
  let pressure: Double
  /// is of type Double, Humidity, %
  let humidity: Double
  /// is of type Double, Minimum temperature at the moment. This is deviation from current temp that is possible for large cities and megalopolises geographically expanded (use these parameter optionally). Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.
  let minimumTemperature: Double
  /// is of type Double, Maximum temperature at the moment. This is deviation from current temp that is possible for large cities and megalopolises geographically expanded (use these parameter optionally). Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.
  let maximumTemperature: Double
  
  /// Initializer of WeatherMainDetails
  ///
  /// - Parameters:
  ///   - temperature: is of type Double, gets the temperature of the location
  ///   - pressure: is of type Double, gets the pressure of the location
  ///   - humidity: is of tyoe Double, gets the humidity of the location
  ///   - maximumTemperature: is of type Double, gets the max temperature of the location
  ///   - minimumTemperature: is of type Double, gets the min temperature of the location
  init(with temperature: Double, pressure: Double, humidity: Double, maximumTemperature: Double, minimumTemperature: Double) {
    self.temperature = temperature
    self.pressure = pressure
    self.humidity = humidity
    self.maximumTemperature = maximumTemperature
    self.minimumTemperature = minimumTemperature
  }
}
