//
//  ContentView.swift
//  NewsAppiOS
//
//  Created by Pragati RAWAT on 12/2/23.
//

import SwiftUI

struct NewsMainView: View {
    @StateObject var newsViewModel: NewsViewModel
    
    init() {
        
#if DEBUG
        if UITestingHelper.isUITesting {
            
            let mock: APIServiceProtocol = UITestingHelper.isNewsAPISuccessful ? APIServiceResponseSuccessMock() : APIServiceResponseFailureMock()
            _newsViewModel = StateObject(wrappedValue: NewsViewModel(apiService: mock))
        } else {
            _newsViewModel = StateObject(wrappedValue: NewsViewModel())
        }
#else
        _newsViewModel = StateObject(wrappedValue: NewsViewModel())
#endif
    }
    
    var body: some View {
        NavigationView {
            NewsListView(newsViewModel: newsViewModel)
                .overlay(overlayView)
                .task {
                    await newsViewModel.loadTask()
                }
                .navigationTitle(String(localized: "navigation.title"))
                .accessibilityHint("Pull to refresh")
        }
    }
    
    @ViewBuilder
    private var overlayView: some View {
        switch newsViewModel.state {
        case .loading:
            ProgressView()
        case .loaded:
            ProgressView().hidden()
        case .failed:
            ErrorView(text: newsViewModel.error?.localizedDescription ?? "error", image: nil).accessibilityIdentifier("errorView")
        }
    }
}

struct NewsMainView_Previews: PreviewProvider {
    static var previews: some View {
        NewsMainView()
    }
}
