//
//  SearchResult.swift
//  GitHubRepos
//
//  Created by Ivan Dekhtiarov on 28.01.2021.
//  Copyright © 2021 Ivan Dekhtiarov. All rights reserved.
//

import Foundation
import RealmSwift

class SearchResult: Object {

    @objc dynamic var searchTerm = ""
    @objc dynamic var sorting = ""
    @objc dynamic var order = ""
    let items = List<Repository>()

    override class func indexedProperties() -> [String] {
        return ["searchTerm", "sorting", "order"]
    }

}
