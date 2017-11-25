//
//  Enumerations.swift
//  Weather
//
//  Created by Rahul Dubey on 11/24/17.
//  Copyright © 2017 Rahul Dubey. All rights reserved.
//

import Foundation

//MARK: - Weather API Service Response
public enum WeatherServiceResponse {
  ///Success Response from the Weather Search Service sending Photos Object
  case success(weather: WeatherBase?)
  ///Failure Response from the Weather Search Service sending Error
  case failure(error: WeatherServiceError?)
}

//MARK: - Weather API Image Service Response
public enum WeatherImageResponse {
  /// Suceess response fromt the Image Service
  case success(data: Data?)
  /// Failure Response from the Image Service
  case failure(error: Error?)
}

//MARK: - Weather API Data Error
public enum DataError: Error {
  /// This case is returned when we get an unexpected response from a service
  case invalidResponse
  /// This case is returned in all errors when accessing Weather API.
  case invalidJSONData
  /// This case returns when we dont have complete information from the service.
  case incompleteData
  /// Unable to download the image data
  case downloadError
}

//MARK: - Weather API Image Download Error
public enum ImageDownloadError: Error {
  /// Image Download Failed
  case downloadFailed
  /// Image request url was Invalid
  case invalidRequest
  /// Image Weather Service Failed
  case serviceFailure
}

