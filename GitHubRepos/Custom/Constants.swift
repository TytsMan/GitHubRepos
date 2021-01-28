//
//  Constants.swift
//  GitHubRepos
//
//  Created by Ivan Dekhtiarov on 24.01.2021.
//  Copyright © 2021 Ivan Dekhtiarov. All rights reserved.
//

import Foundation

struct Constants {

    // The API's base URL
    static let baseUrl = "https://api.github.com"

    // The header fields
    enum HttpHeaderField: String {
        case authentication = "Authorization"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case acceptEncoding = "Accept-Encoding"
    }

    // The content type (JSON)
    enum ContentType: String {
        case json = "application/json"
    }
}
