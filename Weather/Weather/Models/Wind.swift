//
//  Wind.swift
//  Weather
//
//  Created by Rahul Dubey on 11/24/17.
//  Copyright © 2017 Rahul Dubey. All rights reserved.
//

/// Struct Description: Wind of the current weather
struct Wind {
  
  //MARK: Properties
  /// is of type Double, Wind speed: Unit Default: meter/sec, Metric: meter/sec, Imperial: miles/hour.
  let speed: Double
  /// is of type Double, Wind direction, degrees (meteorological)
  let degree: Double
  
  /// Initializer of Wind
  ///
  /// - Parameters:
  ///   - speed: is of type Double, gets the speed of the wind
  ///   - degree: is of type Double, gets the degree of the wind
  init(with speed: Double, degree: Double) {
    self.speed = speed
    self.degree = degree
  }
}
