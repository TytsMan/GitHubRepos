//
//  Repository.swift
//  GitHubRepos
//
//  Created by Ivan Dekhtiarov on 25.01.2021.
//  Copyright © 2021 Ivan Dekhtiarov. All rights reserved.
//

import Foundation
import RealmSwift

class Repository: Object {

    @objc dynamic var repositoryID: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var fullName: String = ""
    @objc dynamic var itemDescription: String = ""
    @objc dynamic var fork: Bool = false
    @objc dynamic var url: String = ""
    @objc dynamic var homepage: String = ""
    @objc dynamic var language: String = ""
    @objc dynamic var stargazersCount: Int = 0
    @objc dynamic var watchersCount: Int = 0
    @objc dynamic var forksCount: Int = 0
    @objc dynamic var owner: User?

    override init() {
        super.init()
    }

    init(tdo: RepositoryTDO) {
        self.repositoryID = tdo.repositoryID
        self.name = tdo.name
        self.fullName = tdo.fullName
        self.itemDescription = tdo.itemDescription ?? ""
        self.fork = tdo.fork
        self.url = tdo.url
        self.homepage = tdo.homepage ?? ""
        self.language = tdo.language ?? ""
        self.stargazersCount = tdo.stargazersCount
        self.watchersCount = tdo.watchersCount
        self.forksCount = tdo.forksCount
        self.owner = .init(tdo: tdo.owner)
    }

    override class func primaryKey() -> String? {
        return "repositoryID"
    }

    override class func ignoredProperties() -> [String] {
        return ["owner"]
    }

}
