//
//  WeatherServiceError.swift
//  Weather
//
//  Created by Rahul Dubey on 11/24/17.
//  Copyright © 2017 Rahul Dubey. All rights reserved.
//

import Foundation

//Error Codes from the Weather API Service
public enum WeatherServiceErrorCodes: Int {
  
  ///Error codes and customized error messages that needs to be displayed.
  case invalidAPIKey = 401
  case invalidQuery = 404
  case invalidParameters = 400
  case success = 200
  case invalidJSON = 10001
  case incompleteData = 10002
  case defaultError
  
  var displayMessage: String {
    switch self {
    case .invalidAPIKey:
      return "Invalid API Key Received"
    case .invalidQuery:
      return "Requested City Not Found"
    case .invalidJSON:
      return "Invalid JSON Data"
    case .incompleteData:
      return "Incomplete Data"
    case .defaultError:
      return "Unable to get weather data, please try later"
    case .invalidParameters:
      return "Invalid Parameters: Nothing to Geocode"
    case .success:
      return ""
    }
  }
}

  //Weather Error class, holds the error messages related to Weather API
  public struct WeatherServiceError {
    
    /// Weather Error Code as per the Weather API
    public let errorCode: Int
    
    /// Error Description
    public let errorDescription: String
    
    /// Error Type Description
    public var displayError: String {
      get {
        switch errorCode {
        case 401:
          return WeatherServiceErrorCodes.invalidAPIKey.displayMessage
        case 404:
          return WeatherServiceErrorCodes.invalidQuery.displayMessage
        case 400:
          return WeatherServiceErrorCodes.invalidParameters.displayMessage
        case 10001:
          return WeatherServiceErrorCodes.invalidJSON.displayMessage
        case 10002:
          return WeatherServiceErrorCodes.incompleteData.displayMessage
        default:
          return errorDescription //Handle other cases as well as of now display Error Description as default
        }
      }
    }
    
    //MARK: - Weather Initializer
    public init(with errorCode: Int, errorDescription: String) {
      self.errorCode = errorCode
      self.errorDescription = errorDescription
    }
}

///TODO: Handle All the Error Code Scenarios, Display Custom Message
enum HTTPStatusCodes: Int {
  // 100 Informational
  case Continue = 100
  case SwitchingProtocols
  case Processing
  // 200 Success
  case OK = 200
  case Created
  case Accepted
  case NonAuthoritativeInformation
  case NoContent
  case ResetContent
  case PartialContent
  case MultiStatus
  case AlreadyReported
  case IMUsed = 226
  // 300 Redirection
  case MultipleChoices = 300
  case MovedPermanently
  case Found
  case SeeOther
  case NotModified
  case UseProxy
  case SwitchProxy
  case TemporaryRedirect
  case PermanentRedirect
  // 400 Client Error
  case BadRequest = 400
  case Unauthorized
  case PaymentRequired
  case Forbidden
  case NotFound
  case MethodNotAllowed
  case NotAcceptable
  case ProxyAuthenticationRequired
  case RequestTimeout
  case Conflict
  case Gone
  case LengthRequired
  case PreconditionFailed
  case PayloadTooLarge
  case URITooLong
  case UnsupportedMediaType
  case RangeNotSatisfiable
  case ExpectationFailed
  case ImATeapot
  case MisdirectedRequest = 421
  case UnprocessableEntity
  case Locked
  case FailedDependency
  case UpgradeRequired = 426
  case PreconditionRequired = 428
  case TooManyRequests
  case RequestHeaderFieldsTooLarge = 431
  case UnavailableForLegalReasons = 451
  // 500 Server Error
  case InternalServerError = 500
  case NotImplemented
  case BadGateway
  case ServiceUnavailable
  case GatewayTimeout
  case HTTPVersionNotSupported
  case VariantAlsoNegotiates
  case InsufficientStorage
  case LoopDetected
  case NotExtended = 510
  case NetworkAuthenticationRequired
}
