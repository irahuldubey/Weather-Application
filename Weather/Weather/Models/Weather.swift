//
//  Weather.swift
//  Weather
//
//  Created by Rahul Dubey on 11/24/17.
//  Copyright © 2017 Rahul Dubey. All rights reserved.
//

import Foundation

/// Struct Description: Weather condition of the current or queried location
public struct Weather {
  
  //MARK: - Properties
  /// is of type Int, Weather condition id
  public let identifier: Int
  /// is of type String, Group of weather parameters (Rain, Snow, Extreme etc.)
  public let parameters: String
  /// is of type String, Weather condition within the group
  public let description: String
  /// is of type String, Weather icon id
  public let icon: String

  /// Weather API Initializer
  ///
  /// - Parameters:
  ///   - weatherId: is of type Int, Weather ID
  ///   - parameters: is of type String, Gives Conditions
  ///   - description: is of type String, Gives the description of the weather
  ///   - icon: id of type String, Id of the Image which will download the image
  init(with weatherId: Int, parameters: String, description: String, icon: String) {
    self.identifier = weatherId
    self.parameters = parameters
    self.description = description
    self.icon = icon
  }
}
