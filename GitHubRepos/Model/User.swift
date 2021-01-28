//
//  User.swift
//  GitHubRepos
//
//  Created by Ivan Dekhtiarov on 28.01.2021.
//  Copyright © 2021 Ivan Dekhtiarov. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object {

    @objc dynamic var userID: Int = 0
    @objc dynamic var login: String = ""
    @objc dynamic var avatarURL: String = ""
    @objc dynamic var gravatarID: String = ""
    @objc dynamic var type: String = ""
    @objc dynamic var siteAdmin: Bool = false

    override init() {
        super.init()
    }

    init(tdo: UserTDO) {
        self.userID = tdo.userID
        self.login = tdo.login
        self.avatarURL = tdo.login
        self.gravatarID = tdo.gravatarID
        self.type = tdo.type
        self.siteAdmin = tdo.siteAdmin
    }

    override class func primaryKey() -> String? {
        return "userID"
    }

}
