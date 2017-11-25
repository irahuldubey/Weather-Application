//
//  Constants.swift
//  Weather
//
//  Created by Rahul Dubey on 11/24/17.
//  Copyright © 2017 Rahul Dubey. All rights reserved.
//

import Foundation

//MARK: - Message Strings
struct Message {
  static let defaultErrror = "Unable to get weather update, Please try again later"
  static let ok = "OK"
  static let alertTitle = "Sorry !! Please try again Later"
  static let welcome = "Go ahead and check the Weather of Any City !"
  static let emptySearch = "Please enter a City"
}

//MARK: - Place Holders
struct PlaceHolders {
  static let search = "Enter your City Name"
  static let degreeCelciusString = "°C"
  static let percentageString = "%"
  static let metres = "m"
  static let pressureUnit = "hPa"
  static let windDegree = "m/s"
}

//MARK: - Recently Searched Key
struct DataStoreKey {
  static let lastSearchedItem: String = "LastSearchedCity"
}
