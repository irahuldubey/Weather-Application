//
//  ImageDownloadManager.swift
//  Weather
//
//  Created by Rahul Dubey on 11/24/17.
//  Copyright © 2017 Rahul Dubey. All rights reserved.
//

import Foundation
import UIKit

//Class Desscription: Call the Image Service to download the Weather Photo, later on this can be extended to cache the images as well.
//At this point we use the Weather API protocol to call the webservice and get the image

///Created Singleton becuase there will be only once instance across the application
final class ImageDownloadManager {
  
  ///Create a default Global Queue, Downlaod the Image on Global Default Queue as of now. Later on we can create our own serial/concurrent and download the images depending on the requirement.
  private let imageQueue = DispatchQueue.global()
  
  ///Create a Singleton Class
  static let sharedInstance = ImageDownloadManager()
  
  /// Create an Service API
  let webService: WeatherServiceAPI = WeatherService()
  
  /// Fetch the image from Weather API
  ///
  /// - Parameters:
  ///   - id: ID of the logo to be fectcehd
  ///   - completionHandler: CompletionHandler with the Image as Parameter
  public func fetchImage(with id: String? = nil, completionHandler: @escaping (UIImage?) -> ()){
    
    guard let imageId = id else {
      print("Invalid Request for the Image") //Will be added to logger API
      return
    }
    
    do {
      try webService.fetchWeatherPhoto(for: imageId) { (imageResponse) in
        switch imageResponse {
        case .success(data: let data):
          if let data = data {
            let image = UIImage.init(data: data)
            completionHandler(image)
          }
          else{
            completionHandler(nil)
          }
        case .failure(error: let error):
          print("ImageDownloadManager: fetchImage: Received an error \(String(describing: error))")
          completionHandler(nil)
        }
      }
    } catch let error {
      print("Image Download Error Received from server \(error)")
    }
  }
}
