//
//  APIClient.swift
//  NewsAppiOS
//
//  Created by Pragati RAWAT on 12/11/23.
//

import Foundation

//struct APIEndpoint {
//    enum RequestType: String {
//        case get = "GET"
//        case post = "POST"
//    }
//
//    let url: String
//    let requestType: RequestType
//    let parameters: [String: Any]?
//    let headers: [String: Any]?
//
//    func createHeaders() -> [String: Any] {
//        var headers = ["Content-Type": "application/json"]
//        if let additionalHeaders = self.headers {
//            for header in additionalHeaders {
//                headers[header.key] = header.value as? String
//            }
//        }
//
//        return headers
//    }
//}

enum APIEndpoint {
    case getLiveNews
}

extension APIEndpoint {
    enum MethodType: Equatable {
        case GET
        case POST(data: Data?)
    }
}

extension APIEndpoint {
    
    var host: String { Constants.GlobalApiConstant.baseUrl }
    
    var path: String {
        switch self {
        case .getLiveNews:
            return Constants.NewsAPIConstants.apiName
        }
    }
    
    var methodType: MethodType {
        switch self {
        case .getLiveNews:
            return .GET
        }
    }
}

extension APIEndpoint {
    var url: URL? {
        let fullPath = host + path + "access_key=cb68f438c2518e73663da8ed33246985"
        return URL(string: fullPath)
    }
}
