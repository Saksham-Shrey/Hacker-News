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
    var id: String {
        return objectID
    }
    var objectID: String
    var _highlightResult: HighlightResult
    var points: Int
}

struct HighlightResult: Codable {
    var author: Author
    var title: Title
    var url: Url
}


struct Author: Codable {
    var value: String
}

struct Title: Codable {
    var value: String
}

struct Url: Codable {
    var value: String
}

