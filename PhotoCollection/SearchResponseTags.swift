//
//  SearchResponseTags.swift
//  PhotoCollection
//
//  Created by Никита on 27.02.2021.
//

import Foundation

// MARK: - SearchResponseTags
struct SearchResponseTags: Codable {
    let period: String
    let count: Int
    let hottags: Hottags
    let stat: String
}

// MARK: - Hottags
struct Hottags: Codable {
    let tag: [Tag]
}

// MARK: - Tag
struct Tag: Codable {
    let content: String
    enum CodingKeys: String, CodingKey {
        case content = "_content"
    }
}
