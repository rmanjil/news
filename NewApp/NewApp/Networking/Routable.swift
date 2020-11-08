//
//  Routable.swift
//  TheNews
//
//  Created by manjil on 11/5/20.
//

import Foundation
import Alamofire

enum Environment {
    static func getServerUrl() -> URL {
        let  urlString = "https://newsapi.org/v2/" //this will be release url
       
        guard let url = URL(string: urlString) else { fatalError("The base url is invalid") }
        
        return url
    }
}

public protocol Routable: URLRequestConvertible {
    
    /// The headers required for every requests
    var headers: [String: String] { get }
    
    /// Need tokenValidation: flag to indicate that when request is perform the token validity is test first
    var needTokenValidation: Bool { get }
    
    var needNewsApiKey: Bool { get }
    /// request URL
    static var baseUrl: URL { get }
}

public extension Routable {
    
    /// Authorization header is put through here to each router
    var headers: [String: String] {
        var headers = [String: String]()
        headers["Content-Type"] = "application/json"
        headers["Accept"] = "application/json"
        //headers["Authorization"] = TokenManager(cacheManager: CacheManager(cacher: UserDefaultCacher())).token?.accessToken ?? "NO_Authorization"
        return headers
    }
    
    /// indicator to indicate that a router will attempt to add token to header when requesting service
    var needTokenValidation: Bool { return true }
    var needNewsApiKey: Bool { return false }
    /// The base url of the endpoint
    static var baseUrl: URL { return Environment.getServerUrl() }
}

