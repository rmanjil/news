//
//  NewsRouter.swift
//  TheNews
//
//  Created by manjil on 11/5/20.
//

import Foundation
import Alamofire
//typealias Parameters = [String: Any]


enum NewsRouter: Routable {
    case headline(Parameters)
    case everything(Parameters)
    case source(Parameters)
    var path: String {
        switch self {
        case .headline:
            return "top-headlines"
        case .everything:
            return "everything"
        case .source:
            return "sources"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var needNewsApiKey: Bool {
        return true
    }
    
    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: NewsRouter.baseUrl.appendingPathComponent(path))
        urlRequest.httpMethod = httpMethod.rawValue
        headers.forEach { urlRequest.addValue($0.value, forHTTPHeaderField: $0.key) }
        switch self {
        case .headline(let parameter), .everything(let parameter), .source(let parameter):
            var newPrameter = parameter
            if needNewsApiKey {
                newPrameter["apiKey"] = "a5d3cbb569384076ba12577e8ac86cc1"
            }
            urlRequest = try URLEncoding.queryString.encode(urlRequest, with: newPrameter)
            break
        }
        return urlRequest
    }
}

