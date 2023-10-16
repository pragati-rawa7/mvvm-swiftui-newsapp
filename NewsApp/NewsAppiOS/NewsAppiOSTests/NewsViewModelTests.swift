//
//  NewsViewModelTests.swift
//  NewsAppiOSTests
//
//  Created by Pragati RAWAT on 14/3/23.
//

import XCTest
@testable import NewsAppiOS

final class NewsViewModelTests: XCTestCase {
    
    @MainActor func test_fetch_news_successfully() async throws {
        // Given
        let mockApiService = APIServiceResponseSuccessMock()
        mockApiService.responseState = .success
        let sut = NewsViewModel(apiService: mockApiService)
        
        // When
        await sut.fetchNewsList()
        
        XCTAssertEqual(sut.state, .loaded)
        XCTAssertNotNil(sut.newsList)
        XCTAssert(sut.newsList!.count > 0, "Data loaded")
    }
    
    @MainActor func test_fetch_news_emptyResponse() async throws {
        // Given
        let mockApiService = APIServiceResponseSuccessMock()
        mockApiService.responseState = .emptyResponse
        let sut = NewsViewModel(apiService: mockApiService)
        
        // When
        await sut.fetchNewsList()
        
        // Then
        XCTAssertNotNil(sut.newsList)
        XCTAssertEqual(sut.state, .loaded)
        XCTAssertEqual(sut.newsList?.count, 0)
    }
    
    
    @MainActor func test_fetch_news_failure() async throws {
        // Given
        let mockApiService = APIServiceResponseFailureMock()
        mockApiService.responseState = .networkError
        let sut = NewsViewModel(apiService: mockApiService)
        
        // When
        await sut.fetchNewsList()
        
        XCTAssert(sut.newsList == nil, "Data not found")
        XCTAssertEqual(sut.state, .failed)
        XCTAssertEqual(sut.error, NetworkingError.invalidData)
    }
    
    @MainActor func test_fetch_news_parsingError() async throws {
        // Given
        let mockApiService = APIServiceResponseFailureMock()
        mockApiService.responseState = .parsingError
        let sut = NewsViewModel(apiService: mockApiService)
        
        // When
        await sut.fetchNewsList()
        
        XCTAssert(sut.newsList == nil, "Data not found")
        XCTAssertEqual(sut.state, .failed)
        XCTAssertNotNil(sut.error)
    }
}
