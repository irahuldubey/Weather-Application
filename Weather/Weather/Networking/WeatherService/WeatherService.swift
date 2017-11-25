//
//  WeatherService.swift
//  Weather
//
//  Created by Rahul Dubey on 11/24/17.
//  Copyright © 2017 Rahul Dubey. All rights reserved.
//

import Foundation

/// Class Description: WeatherService implements WeatherServiceAPI Protocol
public final class WeatherService: WeatherServiceAPI {
  
  ///Create an instance of RestServerManager
  private let serverManager = RestServerManager()
  
  /// Initializer WeatherService
  public init() {  }
  
  /// Fetch the Weather Details from the Weather API
  ///
  /// - Parameters:
  ///   - city: is of type String, Get the City Name as Requested
  ///   - completion: completionHandler has both Success and Failure parameters
  /// - Throws: throws Void
  func fetchWeather(for city: String, withCompletionHandler completion: @escaping (WeatherServiceResponse) -> ()) throws {
    
    // Replace the string with the requested information
    let serviceURLString = RestAPIHelper.getWeatherAPIURL(with: city, appID: APIKeys.weather)
    
    // Add to Logger API Later
    print("Class: WeatherService, Function: fetchWeather, weather details requested for URL\(serviceURLString)")

    /// Make an HTTP GET Request
    serverManager.makeHTTPGETRequest(withURLString: serviceURLString) { (result) in
      
      switch result {
        
        case .success(dictionary: let dictionary):
        
          ///Guard for the Valid JSONDictionary
          guard let dictionary = dictionary, dictionary.count > 0 else {
              print("Class: WeatherService, Function: fetchWeather, Fetched Weather Service : JSON is nil") // Add to Logger API Later
              let customError = WeatherServiceDataParser.parseWeatherServiceCustomError(from: WeatherServiceErrorCodes.invalidJSON)
              completion(.failure(error: customError))
              return
          }
          
          let isSuccessCode = WeatherServiceDataParser.getErrorCode(dictionary: dictionary).isSuccess
          let serviceCode = WeatherServiceDataParser.getErrorCode(dictionary: dictionary).serviceCode
          
          guard isSuccessCode else {
            if let serviceCode = serviceCode {
               if let customCode = WeatherServiceErrorCodes(rawValue: serviceCode) {
               let customError = WeatherServiceDataParser.parseWeatherServiceCustomError(from: customCode)
                print("Class: WeatherService, Function: fetchWeather, Error Received with code\(customCode)") // Add to Logger API Later
                completion(.failure(error: customError))
              }
              else{
                ///Unhandled Data From the service
                print("Class: WeatherService, Function: fetchWeather, Unhandled Code Exception ") // Add to Logger API Later
                let customError = WeatherServiceDataParser.parseWeatherServiceCustomError(from: WeatherServiceErrorCodes.defaultError)
                completion(.failure(error: customError))
              }
            }
            return
          }
      
          ///Guard weather base object
          guard let weatherBaseObject = WeatherServiceDataParser.parseWeatherData(from: dictionary) else {
            print("Class: WeatherService, Function: fetchWeather, Fetched Weather Service : JSON is nil") // Add to Logger API Later
            let customError = WeatherServiceDataParser.parseWeatherServiceCustomError(from: WeatherServiceErrorCodes.incompleteData)
            completion(.failure(error: customError))
            return
          }

          ///Return Scucess with Weather Base Object
          completion(.success(weather: weatherBaseObject))
        
        case .failure(error: let error):
          ///Guard for the Error
          guard let error = error else {
            print("Class: WeatherService, Function: fetchWeather, Error recieved is nil") // Add to Logger API Later
            completion(.failure(error: nil))
            return
          }
          
          ///Parse the webservice error and return to the application
          let wsError = WeatherServiceDataParser.parseWeatherServiceError(from: error)
          completion(.failure(error: wsError))
      }
    }
  }
  
  func fetchWeatherPhoto(for iconID: String, withCompletionHandler completion: @escaping (WeatherImageResponse) -> ()) throws {

    ///Get the Image URL for Icon Id
    let imageURL = RestAPIHelper.getWeatherIconPhoto(with: iconID)
    
    print("Class: WeatherService, Function: fetchWeatherPhoto, Image Download requested for URL\(imageURL)") // Add to Logger API Later

    ///Make a request to server with the given URL string
    serverManager.makeRequestForImage(with: imageURL) { (data, error) in
      
      /// Check for the data and return success in the completion handler
      if let data = data {
        ///Add to Logger : Image Fetch Succeded
        print("Class: WeatherService, Function: fetchWeatherPhoto, Success recieved for url \(imageURL)") // Add to Logger API Later
        completion(.success(data: data))
      }
      
      /// Check the error and return failure in the completion handler
      if error != nil {
        ///Add to Logger : Image Fetch Failed with Error
        print("Class: WeatherService, Function: fetchWeatherPhoto, Failure recieved for url \(imageURL)") // Add to Logger API Later
        completion(.failure(error: ImageDownloadError.downloadFailed))
      }
    }
  }
}

