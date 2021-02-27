//
//  SearchResponse.swift
//  PhotoCollection
//
//  Created by Никита on 27.02.2021.
//

import Foundation

struct SearchResponse: Codable {
    let photos: Photos
    let stat: String
}

// MARK: - Photos
struct Photos: Codable {
    let page, pages, perpage: Int
    let total: String
    let photo: [Photo]
}

// MARK: - Photo
struct Photo: Codable {
    let id, owner, secret, server: String
    let farm: Int
    let title: String
    let ispublic, isfriend, isfamily: Int
    let urlZ: String
    let urlQ: String
    let heightQ, widthQ: Int

    enum CodingKeys: String, CodingKey {
        case id, owner, secret, server, farm, title, ispublic, isfriend, isfamily
        case urlQ = "url_q"
        case urlZ = "url_z"
        case heightQ = "height_q"
        case widthQ = "width_q"
    }
}
