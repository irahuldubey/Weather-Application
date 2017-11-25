//
//  Enumerations.swift
//  Weather
//
//  Created by Rahul Dubey on 11/24/17.
//  Copyright © 2017 Rahul Dubey. All rights reserved.
//

import Foundation


/// RequestType : Service Request Type
///
/// - GET: GET type
/// - POST: POST type
enum RequestType: String {
  case GET
  case POST
}

/// HTTPHeaderField: Extra HTTPHeader Parameters Appended
///
/// - contentType: contentType Defined
/// - applicationJSON: JSON
/// - timeOut: timeout // Need to be changed later as per the requirement
enum HTTPHeaderField: String {
  case contentType = "Content-Type"
  case applicationJSON = "application/json"
  case timeOut = "10"
}

///
/// RestResult: Returns Success and Failure
///
/// - success: JSONDictionary as success TODO: Add Array type in here
/// - failure: Error received from server
enum RestResult {
  case success(dictionary: JSONDictionary?)
  case failure(error: Error?)
}
