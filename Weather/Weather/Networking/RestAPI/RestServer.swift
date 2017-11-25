//
//  RestServer.swift
//  Weather
//
//  Created by Rahul Dubey on 11/24/17.
//  Copyright © 2017 Rahul Dubey. All rights reserved.
//

import Foundation

///Class that makes service calls to the server
final class RestServerManager {
  
  //Create a URL Request with the given URL
  private func getURLRequest(with url: URL) -> URLRequest {
    var request = URLRequest.init(url: url)
    request.httpMethod = RequestType.GET.rawValue
    request.timeoutInterval = Double(HTTPHeaderField.timeOut.rawValue)!
    request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
    request.addValue(HTTPHeaderField.applicationJSON.rawValue,
                     forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
    return request
  }
  
  ///Prevent the singleton from being initialized
  init() {
    print("Class: RestServer, Function: Initializer, Initialized RestServerManager") // Add to Logger API Later
  }
  
  ///Completion Handlers to handler data types
  typealias RestCompletionHandler = (JSONDictionary?) -> ()
  
  ///CompletionHandler JSONDictionary and Error
  typealias RestServerResultCompletionHandler = (RestResult) -> ()
  
  /// HTTP GET Request to make a service call
  ///
  /// - Parameters:
  ///   - urlString: Url String for the service
  ///   - completionHandlerDictionary: is of type Dictionary or Array from Service
  ///   - errorHandler: Throw and Error
  
  func makeHTTPGETRequest(withURLString urlString: String, completionHandler completion: @escaping RestServerResultCompletionHandler) {
    
    //Create a URL object from the URL String
    ///TODO: Need to implement ParameterEncoding (additional functionality)
    guard urlString.count > 0,
          let encodedURLString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
          let url = URL.init(string: encodedURLString) else {
      print("Class: RestServer, Function: makeHTTPGETRequest - Empty URL String") // Add to Logger API Later
      return
    }
    
    //Create an instance of URL Session with the default configuration
    let defaultSession = URLSession(configuration: .default)
    
    /// Create a URL Request with the given URL
    let urlRequest = getURLRequest(with: url)
    
    //Initialize a URLSessionDataTask with the query url and a completion handler to call when the data task completes.
    let dataTask = defaultSession.dataTask(with: urlRequest) { (data,response,error) in
      //Data received throw the data in completion handler
      if let data = data {
        //Check the type returned as JSONDictionary
        if let jsonDictionary = JSONUtilities.parseToDictionary(data){
          print("Class: RestServer, Function: makeHTTPGETRequest - Parsed JSON Data") // Add to Logger API Later
          completion(.success(dictionary: jsonDictionary))
        }
        else{
          /// Check for an array type, if not return nil, as of now sendig as Dictionary if not nil from here
          print("Class: RestServer, Function: makeHTTPGETRequest - Parsed JSON is not of type JSONDictionary") // Add to Logger API Later
          completion(.success(dictionary: nil))
        }
      }
      /// Error received throw the error
      if let error = error {
        ///Return completion result with Error Type
        print("Class: RestServer, Function: makeHTTPGETRequest - Failure: Error Received from WS for URL String : \(url) ") // Add to Logger API Later
        completion(.failure(error: error))
      }
    }
    ///Resume the Data Task Weather API Service
    dataTask.resume()
  }
  
  /// HTTP Request for the Image
  ///
  /// - Parameters:
  ///   - urlString: URL String for the Image
  ///   - completion: is of type Data and Error on service completion
  func makeRequestForImage(with urlString: String?, competionHandler completion : @escaping (Data?, Error?) -> ()) {
    
    //Create a URL object from the URL String
    guard let urlString = urlString,
      let url = URL.init(string: urlString)
      else {
        print("Class: RestServer, Function: makeRequestForImage - Empty URL String/ Empty URL") // Add to Logger API Later
        return
    }
    
    //Create an instance of URL Session with the default configuration
    let defaultSession = URLSession(configuration: .default)
    
    /// Create an instance of URL Rrquest from the URL
    let urlRequest = URLRequest.init(url: url)
    
    //Initialize a URLSessionDataTask with the query url and a completion handler to call when the data task completes.
    let dataTask = defaultSession.dataTask(with: urlRequest) { (data,response,error) in
      
      //Data received throw the data in completion handler
      if let data = data {
        print("Class: RestServer, Function: makeRequestForImage - Success: Received Data from Server") // Add to Logger API Later
        completion(data, nil)
      }
      //Error received throw the error
      if let error = error {
        print("Class: RestServer, Function: makeRequestForImage - Failure: Error received from Server \(url)") // Add to Logger API Later
        completion(nil, error)
      }
    }
    ///Resume the Data Task for Image Service
    dataTask.resume()
  }
}
