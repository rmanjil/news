//
//  Networking.swift
//  TheNews
//
//  Created by manjil on 11/8/20.
//

import Foundation
import Combine
import Alamofire

public enum NetworkingError: LocalizedError {
    case none
    case malformedDataReceived
    case nonParsableErrorReceived
    case tokenValidationFailed
    case tokenRefreshFailed(Error?)
    case failedReason(String, Int)
    case noInternetConnection
    case facebookCancelled
    case custom(String)
    case requestTimedOut
    case badGateway
    case gatewayTimeout
    case unauthorized
    case noData
    
    public var description: String {
        switch self {
        case .none, .facebookCancelled: return ""
        case .malformedDataReceived:
            return "Data couldn't be read from server. Please try again later."
        case .nonParsableErrorReceived:
            return "Data couldn't be parsed from response. Please try again later."
        case .failedReason(let reason, _): return reason
        case .noInternetConnection:
            return "The internet connection appears to be offline."
        case .custom(let msg):
            return msg
        case .tokenValidationFailed:
            return "Unable to validate the access token for request"
        case .tokenRefreshFailed(let error):
            return "Token refresh failed \(error?.localizedDescription ?? "")"
        case .requestTimedOut:
            return "The request timed out."
        case .badGateway:
            return "Server Error (502 Bad Gateway)"
        case .gatewayTimeout:
            return "Server Error (504 Gateway Timeout)"
        case .unauthorized:
            return "Unauthorized user"
        case .noData:
            return "No data"
        }
    }
    
    public var code: Int {
        switch self {
        case .failedReason(_, let code):
            return code
        case .badGateway:
            return 502
        case .gatewayTimeout:
            return 504
        case .unauthorized:
            return 401
        default:
            return 0
        }
    }
}


public struct NetworkingResult {
    public var success: Bool
    public var error: NetworkingError
    public var object: Parameters
    public var objects: [Parameters]
    public var statusCode: Int
    public var message: String
    
    public init(success: Bool = true, error: NetworkingError = .none, object: Parameters  = [:], objects: [Parameters] = [[:]], statusCode: Int = 0) {
        self.success = success
        self.error = error
        self.objects = objects
        self.object = object
        self.statusCode = statusCode
        self.message = ""
    }
}


class Networking {
    
    func request(router: Routable) -> AnyPublisher<NetworkingResult, Never> {
        return Future<NetworkingResult, Never> { [weak self] promise in
            AF.request(router).validate().responseJSON { [weak self] (response) in
                guard let self = self else { return }
                return promise(.success(self.parser(response: response)))
            }
        }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
    
    func parser(response: AFDataResponse<Any>) -> NetworkingResult {
        switch response.result {
        case .success(let data):
            if let dataJson = data as? Parameters  {
                return NetworkingResult(success: true, object: dataJson, statusCode: response.response?.statusCode ?? 0)
            } else if let arrayJson = data as? [Parameters] {
                return NetworkingResult(success: true,objects: arrayJson, statusCode: response.response?.statusCode ?? 0)
            }
            return NetworkingResult(success: false, error: .noData, statusCode: response.response?.statusCode ?? 0)
            
        case .failure(let error):
            if response.response?.statusCode == NSURLErrorTimedOut {
                return NetworkingResult(success: false, error: .requestTimedOut)
            }
            return NetworkingResult(success: false, error: .custom(error.localizedDescription))
        }
    }
    
}
