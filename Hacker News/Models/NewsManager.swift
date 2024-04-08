//
//  NewsManager.swift
//  Hacker News
//
//  Created by Saksham Shrey on 07/04/24.
//

import Foundation
import Alamofire


class NewsManager: ObservableObject {
    
  @Published var news = [News]()
    
    func fetchNews() {
        AF.request("http://hn.algolia.com/api/v1/search?tags=front_page").responseDecodable(of: NewsModel.self) { response in

                    switch response.result {
                        
                    case .success(let receivedNews):
                        DispatchQueue.main.async {
                            self.news = receivedNews.hits
                        }
                        
                    case .failure(let receivedError):
                         print("Error in NewsManager.fetchNews() => \(receivedError.localizedDescription)")
                      
                    }
                }

    }
}
