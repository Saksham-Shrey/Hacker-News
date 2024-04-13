//
//  ContentView.swift
//  Hacker News
//
//  Created by Saksham Shrey on 06/04/24.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    
    
    
    
    
    var body: some View {
        
        TabView(selection: $selectedTab) {
            FrontPageView()
                .tabItem {
                    Image(systemName: "newspaper.fill")
                        .foregroundStyle(Color.accentColor)
                        .preferredColorScheme(.dark)
                    Text("Front Page")
                }
                .opacity(0.8)
                .tag(0)
            
            TopStoriesView()
                .tabItem {
                    Image(systemName: "newspaper.circle.fill")
                    Text("Top Stories")
                }
                .tag(1)
            
        }
    }
}


struct FrontPageView: View {
    
    @ObservedObject var newsManager = NewsManager()
    
    var body: some View {
        NavigationView {
            List(newsManager.frontPageNews) { story in
                NavigationLink(destination: WebView(url: story.url ?? "https://sakshamshrey.bio.link")) {                  VStack(alignment: .leading) {
                    HStack(alignment: .top) {
                        Text(story.title)
                        
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
                    Text("By: \(story.author)")
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
                }
                
            }
            .navigationTitle("Front Page")
        }
        .onAppear {
            self.newsManager.fetchFrontPageNews()
        }
                
    }
}

struct TopStoriesView: View {
    
    @ObservedObject var newsManager = NewsManager()
    
    var body: some View {
        
        NavigationView {
            List(newsManager.topStories) { story in
                
                NavigationLink(destination: WebView(url: story.url ?? "https://sakshamshrey.bio.link")) {                   VStack(alignment: .leading) {
                    HStack(alignment: .top) {
                        Text(story.title)
                        
                        Spacer()
                        
                        Text(String(story.score))
                            .font(.caption)
                            .frame(width: 45, height: 30)
                            .foregroundColor(.secondary)
                            .shadow(radius: 20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(Color.gray.opacity(0.08))
                            )
                        
                    }
                    Text("By: \(story.by)")
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
                }
                
            }
            .navigationTitle("Top Stories")
        }
        .onAppear {
            self.newsManager.fetchTopStories()
        }
    }
}


struct SettingsView: View {
    var body: some View {
        Text("Settings View")
    }
}




#Preview {
    ContentView()
}





