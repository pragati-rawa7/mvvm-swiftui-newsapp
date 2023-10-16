//
//  MockApiServiceClient.swift
//  NewsAppiOSTests
//
//  Created by Pragati RAWAT on 10/13/23.
//

import Foundation
@testable import NewsAppiOS

enum ResponseState {
    case success
    case failure
    case emptyResponse
    case parsingError
}

struct NewsApiFilePath {
    static let successResponse = "news"
    static let emptyResponse = "newsEmptyResponse"
    static let parsingErrorResponse = "newsParsingError"
}

class MockApiServiceClient: APIServiceProtocol {
    func request<T>(session: URLSession, _ endpoint: APIEndpoint, type: T.Type) async throws -> Result<T?, NetworkingError> where T : Decodable, T : Encodable {
        return try StaticJSONMapper.decode(file: "news", type: NewsAPIResponse.self) as! T as! Result<T?, NetworkingError>
    }
    
//    var setResponseState: ResponseState = .success
//    var validUrl = true
//    
//    func executeAPI<T>(endPoint: APIEndpoint) async throws -> Result<T?, FetchError<Any>> where T : Decodable {
////        if !endPoint.url.contains("news") {
////            validUrl = false
////            return .failure(FetchError.failed("Wrong url"))
////        }
//        
//        switch setResponseState {
//        case .success:
//            let result = getNewsApiMockData(filePath: NewsApiFilePath.successResponse)
//            return .success(result.0 as? T)
//        case .emptyResponse:
//            let result = getNewsApiMockData(filePath: NewsApiFilePath.emptyResponse)
//            return .success(result.0 as? T)
//        case .failure:
//            return .failure(FetchError.genericError("Bad request"))
//        case .parsingError:
//            let result = getNewsApiMockData(filePath: NewsApiFilePath.parsingErrorResponse)
//            return .failure(result.1!)
//        }
//    }
//    
//    private func getNewsApiMockData(filePath: String) ->  (NewsAPIResponse?, NetworkingError) {
//        let previewDataURL = Bundle.main.url(forResource: filePath, withExtension: "json")!
//        let jsonDecoder = JSONDecoder()
//        jsonDecoder.dateDecodingStrategy = .iso8601
//        let data = try! Data(contentsOf: previewDataURL)
//
//        do {
//            let model = try jsonDecoder.decode(NewsAPIResponse.self, from: data)
//            return (model, nil)
//        } catch(let error) {
//            return (nil, .failed(error.localizedDescription))
//        }
//    }
}
