//
//  WeatherServiceDataParser.swift
//  Weather
//
//  Created by Rahul Dubey on 11/24/17.
//  Copyright © 2017 Rahul Dubey. All rights reserved.
//

import Foundation

/// Class Description: Parsed Weather JSON Data
final class WeatherServiceDataParser {
  
  /// Parses the JSON Data as per the Weather Base Object
  ///
  /// - Parameter jsonDictionary: JSONDictionary accepted from service
  /// - Returns: return WeatherBase Object
  ///TODO: Need to add Error Handling here to catch the same in WeatherService class
  static func parseWeatherData(from jsonDictionary: JSONDictionary) -> WeatherBase? {
    
    guard jsonDictionary.count > 0 else {
      print("Class: WeatherServiceDataParser, Function: parseWeatherData, JSONDictionary is nil")
      return nil
    }
    
    ///Would have done Exception Handling at this level
    ///This Model Object are mapped as per the values from the service, contractual agreement between the server and client architecture. In the application wherever needed we map to the String, Int, Double type values that need to be shown or converted.
    
    let coordinatesObj = WeatherServiceDataParser.getParsedCoordinatesObject(from: jsonDictionary)
    let weatherObj = WeatherServiceDataParser.getParsedWeatherObject(from: jsonDictionary)
    let weatherMainDetails = WeatherServiceDataParser.getParsedWeatherMainDetails(from: jsonDictionary)
    let windObj = WeatherServiceDataParser.getParsedWindObject(from: jsonDictionary)
    let systemObj = WeatherServiceDataParser.getSystemDetails(from: jsonDictionary)
    
    let base = jsonDictionary[APIResponseKeys.weather.base.rawValue] as? String
    let visibility = jsonDictionary[APIResponseKeys.weather.visibility.rawValue] as? Int
    let dt = jsonDictionary[APIResponseKeys.weather.dt.rawValue] as? Int
    let id = jsonDictionary[APIResponseKeys.weather.id.rawValue] as? Int
    let name = jsonDictionary[APIResponseKeys.weather.name.rawValue] as? String
    let clouds = jsonDictionary[APIResponseKeys.weather.clouds.rawValue] as? Dictionary<String, Int>
    
    return WeatherBase.init(with: coordinatesObj, weather: weatherObj, wind: windObj, systemDetails: systemObj, mainDetails: weatherMainDetails, base: base, visibility: visibility, clouds: clouds, dt: dt, id: id, name: name)
  }
  
  
  /// Parse Coordinate data from the JSONDictionary and return Object
  ///
  /// - Parameter json: JSONDictinary
  /// - Returns: is of type Coordinate Object is parsing is successful else nil
  static func getParsedCoordinatesObject(from json: JSONDictionary) -> Coordinate? {
    guard let coordinateDictionary = json[APIResponseKeys.weather.coordinate.rawValue] as? Dictionary<String, Double>,
          let latitude = coordinateDictionary[APIResponseKeys.weather.latitude.rawValue],
          let longitude = coordinateDictionary[APIResponseKeys.weather.longitude.rawValue] else {
          ///Add to Logger Info
          print("WeatherServiceDataParser : Coordinate: Parser Error: Corrupted Coordinate Data")
          return nil
    }
    return Coordinate.init(withLongitude: latitude, andLongitude: longitude)
  }
  
  
  /// Parse Weather data from JSONDictionary and return Object
  ///
  /// - Parameter json: JSONDictionary from Service
  /// - Returns: is of type Weather Object, returns when parsing is successful else nil
  static func getParsedWeatherObject(from json: JSONDictionary) -> Weather? {
    guard let weatherArrayDictionary = json[APIResponseKeys.weather.weather.rawValue] as? [Dictionary<String, AnyObject>],
          let firstDictionary = weatherArrayDictionary.first,
          let id = firstDictionary[APIResponseKeys.weather.id.rawValue] as? Int,
          let main = firstDictionary[APIResponseKeys.weather.main.rawValue] as? String,
          let description = firstDictionary[APIResponseKeys.weather.description.rawValue] as? String,
          let icon = firstDictionary[APIResponseKeys.weather.icon.rawValue] as? String
      else {
         ///Add to Logger Info
        print("WeatherServiceDataParser : WeatherData: Parser Error: Corrupted Weather Data")
        return nil
    }
    return Weather.init(with: id, parameters: main, description: description, icon: icon)
  }
  
  
  /// Parse Wind Data from the JSON Dictionary
  ///
  /// - Parameter json: is of type JSONDictionary
  /// - Returns: returns Wind Object if the parssed is successful else nil
  static func getParsedWindObject(from json: JSONDictionary) -> Wind? {
    guard let windDictionary = json[APIResponseKeys.weather.wind.rawValue] as? Dictionary<String, Double>
    else {
       ///Add to Logger Info
      print("WeatherServiceDataParser : WindData: Parser Error: Corrupted Wind Data")
      return nil
    }
    let speed = windDictionary[APIResponseKeys.weather.speed.rawValue] ?? 0.0
    let degree = windDictionary[APIResponseKeys.weather.degree.rawValue] ?? 0.0
    return Wind.init(with: speed, degree: degree)
  }
  
  
  /// Parse WeatherMainDetails from the JSONDictionary
  ///
  /// - Parameter json: is of type JSONDescription
  /// - Returns: is of type WeatherMainDetails returns the Object when parsing is successful else nil
  static func getParsedWeatherMainDetails(from json: JSONDictionary) -> WeatherMainDetails? {
    guard let mainDetail = json[APIResponseKeys.weather.main.rawValue] as? Dictionary<String, Double>,
      let temperature = mainDetail[APIResponseKeys.weather.temperature.rawValue],
      let pressure = mainDetail[APIResponseKeys.weather.pressure.rawValue],
      let humidity = mainDetail[APIResponseKeys.weather.humidity.rawValue],
      let temperatureMIN = mainDetail[APIResponseKeys.weather.minTemp.rawValue],
      let temperatureMAX = mainDetail[APIResponseKeys.weather.maxTemp.rawValue]
      else {
         ///Add to Logger Info
        print("WeatherServiceDataParser : WeatherMainDetails: Parser Error: Corrupted WeatherMainDetails Data")
        return nil
    }
    return WeatherMainDetails.init(with: temperature, pressure: pressure, humidity: humidity, maximumTemperature: temperatureMAX, minimumTemperature: temperatureMIN)
  }
  
  
  /// Parse SystemDetails from the JSONDictionary
  ///
  /// - Parameter json: is of type JSONDictionary
  /// - Returns: is of type SystemDetails, return SystemDetails is parsing is successful else nil
  static private func getSystemDetails(from json: JSONDictionary) -> SystemDetails? {
    guard let sysDictionary = json[APIResponseKeys.weather.system.rawValue] as? Dictionary<String, AnyObject>,
      let type = sysDictionary[APIResponseKeys.weather.type.rawValue] as? Int,
      let id = sysDictionary[APIResponseKeys.weather.id.rawValue] as? Int,
      let message = sysDictionary[APIResponseKeys.weather.id.rawValue] as? Double,
      let country = sysDictionary[APIResponseKeys.weather.country.rawValue] as? String,
      let sunrise = sysDictionary[APIResponseKeys.weather.sunrise.rawValue] as? UInt64,
      let sunset = sysDictionary[APIResponseKeys.weather.sunset.rawValue] as? UInt64
      else {
         ///Add to Logger Info
        print("WeatherServiceDataParser : System Details: Parser Error: System Details Data")
        return nil
    }
    return SystemDetails.init(with: type, id: id, message: message, country: country, sunrise: sunrise, sunset: sunset)
  }
  
  
  /// Parse Weather Error Response and Return WeatherServiceError Object
  ///
  /// - Parameter error: is of type Error
  /// - Returns: is of type WeatherServiceError
  static func parseWeatherServiceError(from error: Error) -> WeatherServiceError {
    let nsError = error as NSError
    return WeatherServiceError.init(with: nsError.code, errorDescription: nsError.localizedDescription)
  }
  
  
  /// Parse Custom Error Code and returns WeatherServiceError Object
  ///
  /// - Parameter code: is of type enum ErrorCodes, custom codes from the RestClient
  /// - Returns: is of type WeatherServiceError, object returned
  static func parseWeatherServiceCustomError(from code: WeatherServiceErrorCodes) -> WeatherServiceError {
    return WeatherServiceError.init(with: code.rawValue, errorDescription: code.displayMessage)
  }
  
  
  /// Get the Error Code and Service Success failure depending on the code
  ///
  /// - Parameter dictionary: Parameter as String and AnyObject Dictionary
  /// - Returns: Returns a Tuple as Boolean as Successful and Service Code as Integer
  static func getErrorCode(dictionary: Dictionary<String, AnyObject>) -> (isSuccess: Bool, serviceCode: Int?) {

    ///As of now we get two types for code from the Dictionary one is String type and other is Int Type
    
    var serviceCode: Int?
    
    if let codeAsString = dictionary[APIResponseKeys.weather.cod.rawValue] as? String {
      serviceCode = Int(codeAsString)
    }
    if let codeAsInteger = dictionary[APIResponseKeys.weather.cod.rawValue] as? Int {
      serviceCode = codeAsInteger
    }
     ///Add to Logger Info
    print("Class: WeatherServiceDataParser, Function: getErrorCode, Service Code \(String(describing: serviceCode)))") 
    return (isSuccess: serviceCode == 200, serviceCode: serviceCode)
  }
}
