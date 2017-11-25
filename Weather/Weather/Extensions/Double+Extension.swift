//
//  Double+Extensions.swift
//  Weather
//
//  Created by Rahul Dubey on 11/24/17.
//  Copyright © 2017 Rahul Dubey. All rights reserved.
//

import Foundation

// MARK: - Extension Double
extension Double {
  
  /// Double value to string
  ///
  /// - Returns: return the double value to string
  func toString() -> String {
    return String(format: "%.2f",self)
  }
}
