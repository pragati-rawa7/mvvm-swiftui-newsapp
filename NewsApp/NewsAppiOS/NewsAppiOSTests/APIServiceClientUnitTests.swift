//
//  APIServiceClientUnitTests.swift
//  NewsAppiOSTests
//
//  Created by Pragati RAWAT on 10/15/23.
//

import XCTest
@testable import NewsAppiOS

class APiServiceClientUnitTests: XCTestCase {
    
    private var session: URLSession!
    private var url: URL!
    
    override func setUp() {
        url = URL(string: "http://api.mediastack.com/")
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLSessionProtocol.self]
        session = URLSession(configuration: configuration)
    }
    
    override func tearDown() {
        session = nil
        url = nil
    }
    
    func test_with_successful_response_response_is_valid() async throws {
        
        guard let path = Bundle.main.path(forResource: "news", ofType: "json"),
              let data = FileManager.default.contents(atPath: path) else {
            XCTFail("Failed to get the static users file")
            return
        }
        
        MockURLSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(url: self.url,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)
            return (response!, data)
        }
        
        let response = try await APIClientService.shared.request(session: session,
                                                                 .getLiveNews,
                                                                 type: NewsAPIResponse.self)
        let staticJSON = try StaticJSONMapper.decode(file: "news", type: NewsAPIResponse.self)
        
        switch response {
        case .success(let res):
            XCTAssertEqual(res, staticJSON, "The returned response should be decoded properly")
        case .failure(_):
            print("")
        }
        
    }
    
    func test_with_unsuccessful_response_code_invalid() async {
        
        let invalidStatusCode = 400
        
        MockURLSessionProtocol.loadingHandler = {
            let response = HTTPURLResponse(url: self.url,
                                           statusCode: invalidStatusCode,
                                           httpVersion: nil,
                                           headerFields: nil)
            return (response!, nil)
        }
        
        do {
            _ = try await APIClientService.shared.request(session: session,
                                                          .getLiveNews,
                                                          type: NewsAPIResponse.self)
        } catch {
            
            guard let networkingError = error as? NetworkingError else {
                XCTFail("Got the wrong type of error, expecting NetworkingManager NetworkingError")
                return
            }
            
            XCTAssertEqual(networkingError,
                           NetworkingError.invalidStatusCode(statusCode: invalidStatusCode),
                           "Error should be a networking error which throws an invalid status code")
            
        }
    }
    
}
