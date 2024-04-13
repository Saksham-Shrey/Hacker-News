import SwiftUI
import Alamofire

var topStories = [Int]()

func fetchTopStories() {
    AF.request("http://hacker-news.firebaseio.com/v0/topstories.json").responseDecodable(of: [Int].self) { response in
        
        switch response.result {
            
        case .success(let receivedNews):
            DispatchQueue.main.async {
                topStories = receivedNews
                print(topStories[0])
            }
            
        case .failure(let receivedError):
            print("Error in NewsManager.fetchNews() => \(receivedError.localizedDescription)")
            
        }
    }
}

fetchTopStories()


