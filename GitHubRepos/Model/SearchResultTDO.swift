//
//  SearchResultTDO.swift
//  GitHubRepos
//
//  Created by Ivan Dekhtiarov on 24.01.2021.
//  Copyright © 2021 Ivan Dekhtiarov. All rights reserved.
//

import Foundation

struct SearchResultWrapperTDO<T: Codable>: Codable {
    let totalCount: Int
    let incompleteResults: Bool
    let items: [T]

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items
    }
}
