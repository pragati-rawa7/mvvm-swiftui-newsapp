//
//  NewsAppiOSApp.swift
//  NewsAppiOS
//
//  Created by Pragati RAWAT on 14/2/23.
//


#if DEBUG
import Foundation

enum ErrorState {
    case parsingError
    case invalidUrl
    case networkError
}

class APIServiceResponseFailureMock: APIServiceProtocol {
    var responseState: ErrorState = .networkError
    
    func request<T>(session: URLSession, _ endpoint: APIEndpoint, type: T.Type) async throws -> Result<T?, NetworkingError> where T : Decodable, T : Encodable {
        
        switch responseState {
        case .parsingError:
            _ = try StaticJSONMapper.decode(file: "newsParsingError", type: NewsAPIResponse.self)
            throw NetworkingError.invalidData
        case .invalidUrl:
            throw NetworkingError.invalidUrl
        case .networkError:
            throw NetworkingError.invalidData
        }
    }
}

#endif
