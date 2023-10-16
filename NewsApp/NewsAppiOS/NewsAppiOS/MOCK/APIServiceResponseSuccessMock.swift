//
//  NewsAppiOSApp.swift
//  NewsAppiOS
//
//  Created by Pragati RAWAT on 14/2/23.
//

#if DEBUG
import Foundation

enum ResponseState {
    case success
    case emptyResponse
}

class APIServiceResponseSuccessMock: APIServiceProtocol {
    var responseState: ResponseState = .success

    func request<T>(session: URLSession, _ endpoint: APIEndpoint, type: T.Type) async throws -> Result<T?, NetworkingError> where T : Decodable, T : Encodable {
        switch responseState {
        case .success:
            let result = try StaticJSONMapper.decode(file: "news", type: NewsAPIResponse.self)
            return .success(result as? T)
        case .emptyResponse:
            let result = try StaticJSONMapper.decode(file: "newsEmptyResponse", type: NewsAPIResponse.self)
            return .success(result as? T)
            
        }
    }
}

#endif
