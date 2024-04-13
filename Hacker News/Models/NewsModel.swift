//
//  NewsModel.swift
//  Hacker News
//
//  Created by Saksham Shrey on 07/04/24.
//

import Foundation

struct NewsModel: Codable {
    var hits: [News]
}


struct News: Codable, Identifiable {
    var id: Int {
        return story_id
    }
    
    var story_id: Int
    var author: String
    var title: String
    var url: String?
    var points: Int
    
}


struct TopStory: Codable, Identifiable {
    var id: Int
    var by: String
    var title: String
    var url: String?
    var score: Int
    
}
//
//struct HighlightResult: Codable {
//    var url: Url
//}
//
//struct Url: Codable {
//    var value: String
//}
//
//struct Author: Codable {
//    var author: String
//}
