//
//  NewsViewModel.swift
//  NewsAppiOS
//
//  Created by Pragati RAWAT on 12/3/23.
//

import Foundation

enum DataLoadingState<T>: Equatable {
    case loading
    case loaded
    case failed
    
    static func == (lhs: DataLoadingState<T>, rhs: DataLoadingState<T>) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true
        case (.loaded, .loaded):
            return true
        case (.failed, .failed):
            return true
        default:
            return false
        }
    }
}

class NewsViewModel: ObservableObject {
    @MainActor @Published var newsList: [NewsData]?
    @MainActo @Published private(set) var error: NetworkingError?
    @MainActor @Published private (set) var state : DataLoadingState<Void> = .loading
    
    private let apiService: APIServiceProtocol!
    
    init(apiService: APIServiceProtocol = APIClientService.shared) {
        self.apiService = apiService
    }
    
    @MainActor
    func fetchNewsList() async {
        state = .loading
        do {
            let response = try await apiService.request(session: .shared, .getLiveNews, type: NewsAPIResponse.self)
            
            switch response {
            case .success(let response):
                state = .loaded
                newsList = response?.data
            case .failure(let error):
                state = .failed
                self.error = error
            }
        } catch(let error) {
            state = .failed
            if let networkingError = error as? NetworkingError {
                self.error = networkingError
            } else {
                self.error = NetworkingError.custom(error: error)
            }
        }
    }
    
    @Sendable
    func loadTask() async {
        await fetchNewsList()
    }
}
