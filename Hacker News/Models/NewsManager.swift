//
//  NewsManager.swift
//  Hacker News
//
//  Created by Saksham Shrey on 07/04/24.
//

import Foundation
import Alamofire


class NewsManager: ObservableObject {
    
    @Published var frontPageNews = [News]()
    @Published var topStories = [TopStory]()
    @Published var searchNews = [News]()
    @Published var query = ""
    
    func fetchFrontPageNews() {
        AF.request("https://hn.algolia.com/api/v1/search?tags=front_page").responseDecodable(of: NewsModel.self) { response in
            
            switch response.result {
                
            case .success(let receivedNews):
                DispatchQueue.main.async {
                    self.frontPageNews = receivedNews.hits
                }
                
            case .failure(let receivedError):
                print("Error in NewsManager.fetchNews() => \(receivedError.localizedDescription)")
                
            }
        }
        
    }
    
    func fetchTopStories() {
        AF.request("http://hacker-news.firebaseio.com/v0/topstories.json").responseDecodable(of: [Int].self) { response in
            
            switch response.result {
                
            case .success(let receivedNews):
                DispatchQueue.main.async {
                    for story in receivedNews {
                        AF.request("https://hacker-news.firebaseio.com/v0/item/\(story).json").responseDecodable(of: TopStory.self) { response in
                            
                            switch response.result {
                                
                            case .success(let receivedNews):
                                DispatchQueue.main.async {
                                    self.topStories.append(receivedNews)
                                }
                                
                            case .failure(let receivedError):
                                print("Error in NewsManager.fetchTopStories-nested() => \(receivedError.localizedDescription)")
                                
                            }
                        }
                        
                    }
                }
                
            case .failure(let receivedError):
                print("Error in NewsManager.fetchTopStories() => \(receivedError.localizedDescription)")
                
            }
        }
        
    }
    
    func fetchSearchNews() {
        AF.request("https://hn.algolia.com/api/v1/search?query=\(query)").responseDecodable(of: NewsModel.self) { response in
            
            switch response.result {
                
            case .success(let receivedNews):
                DispatchQueue.main.async {
                    self.searchNews = receivedNews.hits
                }
                
            case .failure(let receivedError):
                print("Error in NewsManager.fetchSearchNews() => \(receivedError.localizedDescription)")
                
            }
        }
        
    }
}
