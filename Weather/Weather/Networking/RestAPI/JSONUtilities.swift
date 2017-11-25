//
//  JSONUtilities.swift
//  Weather
//
//  Created by Rahul Dubey on 11/24/17.
//  Copyright © 2017 Rahul Dubey. All rights reserved.
//

import Foundation

/// Dictionary describing a JSON object
public typealias JSONDictionary = [String: AnyObject]

///Class Description: JSONUtilities : Utilities for JSON, Later Parsing an Array can also be added.
///This is open for Modification as of now, it cant be extended it should be extended as needed. It may have different files shared between platforms. Can add composition on inheritence approach as needed later
final class JSONUtilities {
  // Convert data to data to Dictionary
  ///
  /// - Parameter data: as of type Data
  /// - Returns: as of type Dictionary
  static func parseToDictionary(_ data: Data) -> JSONDictionary? {
    guard let parsedJson = try? JSONSerialization.jsonObject(with: data, options:.allowFragments) as? JSONDictionary else {
      ///Add to logger API
      print("JSONUtilities: Function: ParseToDictionary - Invalid JSON data")
      return nil
    }
    return parsedJson
  }
}
