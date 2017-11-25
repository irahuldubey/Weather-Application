//
//  Coordinate.swift
//  Weather
//
//  Created by Rahul Dubey on 11/24/17.
//  Copyright © 2017 Rahul Dubey. All rights reserved.
//

/// Struct Description: Coordinate of the latitude and longitude of the location
public struct Coordinate {

  //MARK: Properties
  
  ///is of type Double, longitude of the location
  public let longitude: Double
  ///is of type Double, latitude of the location
  public let latitude: Double 
  
  /// Initializer Coordinate Class
  ///
  /// - Parameters:
  ///   - latitude: is of type Double, latitude of the location
  ///   - longitude: is of type Double, longitude of the location
  init(withLongitude latitude: Double, andLongitude longitude: Double) {
      self.latitude = latitude
      self.longitude = longitude
  }
}
