//
//  NewsListView.swift
//  NewsAppiOS
//
//  Created by Pragati RAWAT on 12/2/23.
//
import SwiftUI

struct NewsListView: View {
    @ObservedObject var newsViewModel: NewsViewModel
    
    private var newsSections: [NewsData] {
        if let section = newsViewModel.newsList {
            return section
        }
        return []
    }
    
    var body: some View {
        List {
            ForEach(newsSections) { section in
                NewsRowView(newsSection: section)
                .accessibilityIdentifier("NEWS_CELL")
            }
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
        .refreshable(action: newsViewModel.loadTask)
        .accessibilityIdentifier("NEWS_LIST")
    }
}

struct NewsListView_Previews: PreviewProvider {
        
    static var previews: some View {
        NavigationView {
            NewsListView(newsViewModel: NewsViewModel(apiService: APIServiceResponseSuccessMock()))
        }
    }
}

