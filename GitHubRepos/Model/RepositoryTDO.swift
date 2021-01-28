//
//  RepositoryTDO.swift
//  GitHubRepos
//
//  Created by Ivan Dekhtiarov on 24.01.2021.
//  Copyright © 2021 Ivan Dekhtiarov. All rights reserved.
//

// languagelanguageimport Foundation

struct RepositoryTDO: Codable {
    let repositoryID: Int
    let nodeID, name, fullName: String
    let owner: UserTDO
    let itemPrivate: Bool
    let htmlURL: String
    let itemDescription: String?
    let fork: Bool
    let url: String
    let createdAt, updatedAt, pushedAt: String?
    let homepage: String?
    let size, stargazersCount, watchersCount: Int
    let language: String?
    let forksCount, openIssuesCount: Int
    let masterBranch, defaultBranch: String?
    let score: Int
    let forks, openIssues, watchers: Int?
    let hasIssues, hasProjects, hasPages, hasWiki: Bool?
    let hasDownloads, archived: Bool?
    let disabled: Bool?

    enum CodingKeys: String, CodingKey {
        case repositoryID = "id"
        case nodeID = "node_id"
        case name
        case fullName = "full_name"
        case owner
        case itemPrivate = "private"
        case htmlURL = "html_url"
        case itemDescription = "description"
        case fork, url
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case pushedAt = "pushed_at"
        case homepage, size
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case language
        case forksCount = "forks_count"
        case openIssuesCount = "open_issues_count"
        case masterBranch = "master_branch"
        case defaultBranch = "default_branch"
        case score
        case forks
        case openIssues = "open_issues"
        case watchers
        case hasIssues = "has_issues"
        case hasProjects = "has_projects"
        case hasPages = "has_pages"
        case hasWiki = "has_wiki"
        case hasDownloads = "has_downloads"
        case archived, disabled
    }
}
