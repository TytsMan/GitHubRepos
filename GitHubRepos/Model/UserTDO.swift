//
//  UserTDO.swift
//  GitHubRepos
//
//  Created by Ivan Dekhtiarov on 24.01.2021.
//  Copyright © 2021 Ivan Dekhtiarov. All rights reserved.
//

import Foundation

struct UserTDO: Codable {
    let login: String
    let userID: Int
    let nodeID: String
    let avatarURL: String
    let gravatarID: String
    let type: String
    let siteAdmin: Bool

    enum CodingKeys: String, CodingKey {
        case login
        case userID = "id"
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case type
        case siteAdmin = "site_admin"
    }
}
