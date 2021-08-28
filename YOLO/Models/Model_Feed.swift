//
//  Model_Feed.swift
//  YOLO
//
//  Created by Boons&Blessings Apps on 10/12/20.
//  Copyright © 2020 Boons&Blessings Apps. All rights reserved.
//

import Foundation


// MARK: - Feed
struct Feed: Codable {
    let id, userID: Int?
    let mediaType: String?
    let media: String?
    let sticker: String?
    let createdAt, humanReadableTime: String?
    let user: User?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case mediaType = "media_type"
        case media, sticker
        case createdAt = "created_at"
        case humanReadableTime = "human_readable_time"
        case user
    }
}

// MARK: - User
struct User: Codable {
    let id: Int?
    let fullName: String?
    let profile: String?

    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case profile
    }
}

var arrFeed : [Feed] = []
