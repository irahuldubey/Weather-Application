//
//  SystemDetail.swift
//  Weather
//
//  Created by Rahul Dubey on 11/24/17.
//  Copyright © 2017 Rahul Dubey. All rights reserved.
//

/// Struct Description: System Details of the weather
struct SystemDetails {
  
  //MARK: - Properties
  
  /// is of type Int, Internal System Parameter
  let type: Int
  /// is of type Int, Internal System Parameter
  let id: Int
  /// is of type Double, Internal System Parameter
  let message: Double
  /// is of type String, country of the location
  let country: String
  /// is of type UInt64, returns date in UTC format, Safer side it should be accepted in UInt64 type
  let sunrise: UInt64
  /// is of type UInt64, returns date in UTC format, Safer side it should be accepted in UInt64 type
  let sunset: UInt64
  
  /// Initializer of System Details
  ///
  /// - Parameters:
  ///   - type: is fo type Int, is an Internal Parameter
  ///   - id: is of type Int, is an Internal Parameter
  ///   - message: is of type Double, is an Internal Parameter
  ///   - country: is of type String, is the country of the location
  ///   - sunrise: is of type UInt64, Date in UTC format of the location
  ///   - sunset: is of type UInt64, Date in UTC format of the location
  init(with type: Int, id: Int, message: Double, country: String, sunrise: UInt64, sunset: UInt64) {
    self.type = type
    self.id = id
    self.message = message
    self.country = country
    self.sunrise = sunrise
    self.sunset = sunset
  }
}
