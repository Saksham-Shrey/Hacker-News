//
//  ContentView.swift
//  Hacker News
//
//  Created by Saksham Shrey on 06/04/24.
//

import SwiftUI

struct ContentView: View {
    
    
    @ObservedObject var newsManager = NewsManager()
    
    
    var body: some View {
        
        NavigationView {
            List(newsManager.news) { story in
                NavigationLink(destination: WebView(url: story._highlightResult.url.value)) {                  VStack(alignment: .leading) {
                    HStack(alignment: .top) {
                        Text(story._highlightResult.title.value)
                        
                        Spacer()
                        
                        Text(String(story.points))
                            .font(.caption)
                            .frame(width: 45, height: 30)
                            .foregroundColor(.secondary)
                            .shadow(radius: 20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(Color.gray.opacity(0.08))
                            )
                        
                    }
                    Text("By: \(story._highlightResult.author.value)")
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
                }
                .navigationTitle("Hacker News")
            }
            .onAppear {
                self.newsManager.fetchNews()
            }
        }
    }
}




#Preview {
    ContentView()
}
