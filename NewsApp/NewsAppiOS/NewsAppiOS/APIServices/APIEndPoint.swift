//
//  APIClient.swift
//  NewsAppiOS
//
//  Created by Pragati RAWAT on 12/11/23.
//

import Foundation

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
