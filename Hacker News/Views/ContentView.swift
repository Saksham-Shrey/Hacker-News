//
//  ContentView.swift
//  Hacker News
//
//  Created by Saksham Shrey on 06/04/24.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    @ObservedObject var newsManager: NewsManager = NewsManager()
    
    var body: some View {
        
        TabView(selection: $selectedTab) {
            FrontPageView(newsManager: newsManager)
                .tabItem {
                    Image(systemName: "newspaper.fill")
                        .foregroundStyle(Color.accentColor)
                        .preferredColorScheme(.dark)
                    Text("Front Page")
                }
                .opacity(0.8)
                .tag(0)
            
            TopStoriesView(newsManager: newsManager)
                .tabItem {
                    Image(systemName: "newspaper.circle.fill")
                    Text("Top Stories")
                }
                .tag(1)
            
            SearchView(newsManager: newsManager)
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
                .tag(2)
        }
    }
}


struct FrontPageView: View {
    
    @ObservedObject var newsManager: NewsManager
    
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
    
    @ObservedObject var newsManager: NewsManager
    
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

struct SearchView: View {
    
    @ObservedObject var newsManager: NewsManager
    @State var str = ""
    @State var isSubmitted = false
    
    var body: some View {
        
        if !isSubmitted {
            VStack {
                TextField(
                    "Enter Search Query",
                    text: $newsManager.query,
                    onCommit: {
                        querySent()
                        print(newsManager.query)
                    }
                )
                .font(.custom("Impact", size: 24))
                .foregroundStyle(Color(.systemBrown))
                .opacity(0.8)
                .bold()
                .padding(.horizontal, 100)
                .clipShape(RoundedRectangle(cornerRadius: 80))
                .disableAutocorrection(true)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.clear)
                        .frame(width: 240, height: 60)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 4)
                        )
                )
                
                
                Button(action: {
                    querySent()
                }, label: {
                    Text("Search")
                        .font(.custom("MarkerFelt-Wide", size: 20))
                        .frame(width: 60, height: 60, alignment: .center)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .foregroundStyle(Color.brown)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.secondary)
                                .frame(width: 80, height: 40)
                        )
                })
                .padding()
            }
        } else {
            NavigationView {
                List(newsManager.searchNews) { story in
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
                .navigationTitle(newsManager.query)
            }
            .onAppear {
                self.newsManager.fetchSearchNews()
            }
            .onDisappear {

            }
            
        }
        
        
    }
    func querySent() {
        self.isSubmitted = true
    }
}


#Preview {
    ContentView()
}



