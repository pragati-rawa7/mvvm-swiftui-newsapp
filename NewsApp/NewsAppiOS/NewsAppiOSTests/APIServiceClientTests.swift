//
//  APIServiceClientTests.swift
//  NewsAppiOSTests
//
//  Created by Pragati RAWAT on 10/13/23.
//

import XCTest
@testable import NewsAppiOS

class APIServiceClientTests: XCTestCase {
    
    @MainActor func test_News_APIURL() async {
        let urlPath = Constants.NewsAPIConstants.apiName
        let endpoint = APIEndpoint(url: Constants.NewsAPIConstants.apiName, requestType: .get, parameters: nil, headers: nil)
        
        let mockApiClient = MockApiServiceClient()
        
        mockApiClient.executeAPI(endPoint: endpoint)

        
    }

}
