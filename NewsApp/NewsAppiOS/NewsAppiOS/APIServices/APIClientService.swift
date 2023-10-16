//
//  NewsAPIService.swift
//  NewsAppiOS
//
//  Created by Pragati RAWAT on 12/2/23.
//

import Foundation

enum NetworkingError: LocalizedError {
    case invalidUrl
    case custom(error: Error)
    case invalidStatusCode(statusCode: Int)
    case invalidData
    case failedToDecode(error: Error)
}

final class APIClientService: APIServiceProtocol {
    
    static let shared = APIClientService()
    
    private init() {}
    
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    func request<T>(session: URLSession, _ endpoint: APIEndpoint, type: T.Type) async throws -> Result<T?, NetworkingError> where T : Decodable, T : Encodable {
        guard let url = endpoint.url else {
            throw NetworkingError.invalidUrl
        }
        
        let request = buildRequest(from: url, methodType: endpoint.methodType)
        
        do {
            let (data, response) = try await session.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse,
                  (200..<300).contains(httpResponse.statusCode)  else {
                let statusCode = (response as! HTTPURLResponse).statusCode
                throw NetworkingError.invalidStatusCode(statusCode: statusCode)
            }
            do {
                let model = try jsonDecoder.decode(T.self, from: data)
                return .success(model)
                
            } catch(let error) {
                throw (NetworkingError.failedToDecode(error: error))
            }
        } catch (let error) {
            return .failure(NetworkingError.failedToDecode(error: error))
        }
    }
}

extension NetworkingError: Equatable {
    
    static func == (lhs: NetworkingError, rhs: NetworkingError) -> Bool {
        switch(lhs, rhs) {
        case (.invalidUrl, .invalidUrl):
            return true
        case (.custom(let lhsType), .custom(let rhsType)):
            return lhsType.localizedDescription == rhsType.localizedDescription
        case (.invalidStatusCode(let lhsType), .invalidStatusCode(let rhsType)):
            return lhsType == rhsType
        case (.invalidData, .invalidData):
            return true
        case (.failedToDecode(let lhsType), .failedToDecode(let rhsType)):
            return lhsType.localizedDescription == rhsType.localizedDescription
        default:
            return false
        }
    }
}

extension NetworkingError {
    
    var errorDescription: String? {
        switch self {
        case .invalidUrl:
            return "URL isn't valid"
        case .invalidStatusCode:
            return "Status code falls into the wrong range"
        case .invalidData:
            return "Response data is invalid"
        case .failedToDecode:
            return "Failed to decode"
        case .custom(let err):
            return "Something went wrong \(err.localizedDescription)"
        }
    }
}

private extension APIClientService {
    func buildRequest(from url: URL,
                      methodType: APIEndpoint.MethodType) -> URLRequest {
        var request = URLRequest(url: url)
        
        switch methodType {
        case .GET:
            request.httpMethod = "GET"
        case .POST(let data):
            request.httpMethod = "POST"
            request.httpBody = data
        }
        return request
    }
}

