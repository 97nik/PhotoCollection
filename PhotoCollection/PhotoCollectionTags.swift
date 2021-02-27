//
//  PhotoCollectionTags.swift
//  PhotoCollection
//
//  Created by Никита on 27.02.2021.
//

import Foundation


// MARK: - PhotoCollectionTags
struct PhotoCollectionTags: Codable {
    let photos: PhotosTag
    let stat: String
}

// MARK: - Photos
struct PhotosTag: Codable {
    let photo: [PhotoTag]
}

// MARK: - Photo
struct PhotoTag: Codable {
    let id, secret, server: String
    let farm: Int
    let owner, username, title: String
    let ispublic, isfriend, isfamily: Int
    let urlZ: String
    let heightZ, widthZ: Int
    let urlQ: String
    let heightQ, widthQ: Int

    enum CodingKeys: String, CodingKey {
        case id, secret, server, farm, owner, username, title, ispublic, isfriend, isfamily
        case urlZ = "url_z"
        case heightZ = "height_z"
        case widthZ = "width_z"
        case urlQ = "url_q"
        case heightQ = "height_q"
        case widthQ = "width_q"
    }
}
