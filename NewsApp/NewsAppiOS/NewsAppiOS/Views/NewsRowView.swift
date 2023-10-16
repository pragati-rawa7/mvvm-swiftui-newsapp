//
//  NewsRowView.swift
//  NewsAppiOS
//
//  Created by Pragati RAWAT on 12/2/23.
//

import SwiftUI

struct NewsRowView: View {
        
    let newsSection: NewsData

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            
            if let url = URL(string: newsSection.image ?? "") {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        HStack {
                            Spacer()
                            ProgressView()
                            Spacer()
                        }
                        
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                        
                    case .failure:
                        HStack {
                            Spacer()
                            Image("NoImageFound")
                                .aspectRatio(contentMode: .fit)
                            Spacer()
                        }
                        
                        
                    @unknown default:
                        fatalError()
                    }
                }
                .frame(minHeight: 200, maxHeight: 300)
                .background(Color.gray.opacity(0.3))
                .clipped()
            } else {
                Image("NoImageFound")
                    .aspectRatio(contentMode: .fit)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(newsSection.source ?? "")
                        .lineLimit(1)
                        .foregroundColor(.secondary)
                        .font(.caption)
                    
                    Spacer()
                    
                    Text(newsSection.publishedAt ?? "")
                        .lineLimit(1)
                        .font(.caption)
                }
                
                Text(newsSection.title ?? "")
                    .font(.headline)
                    .fixedSize(horizontal: false, vertical: true)
                
                Text(newsSection.description ?? "")
                    .font(.subheadline)
                    .fixedSize(horizontal: false, vertical: true)
            }.padding([.horizontal, .bottom])
        }
    }
}

struct NewsRowView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List {
                let response = try! StaticJSONMapper.decode(file: "news", type: NewsAPIResponse.self)
                NewsRowView(newsSection: response.data![0])
                    .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
            .listStyle(.plain)
        }
    }
}
