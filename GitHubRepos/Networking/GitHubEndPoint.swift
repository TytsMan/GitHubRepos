//
//  GitHubSeachEndPoint.swift
//  GitHubRepos
//
//  Created by Ivan Dekhtiarov on 24.01.2021.
//  Copyright © 2021 Ivan Dekhtiarov. All rights reserved.
//

import Foundation
import Alamofire

enum Order: String {
    case asc
    case desc
}

enum RepositoriesSort: String {
    case stars
    case forks
    case bestMatch
    case recency = "updated"

    static let allCases: [RepositoriesSort] = [.stars, .forks, .bestMatch, .recency]

    var readable: String {
        switch self {
        case .stars:
            return "Stars"
        case .forks:
            return "Forks"
        case .bestMatch:
            return "Best match"
        case .recency:
            return "Recently"
        }
    }

}

enum GitHubEndPoint: URLRequestConvertible {

    case fetchRepositories(searchTerm: String, sort: RepositoriesSort, order: Order, limit: Int)
    case repositoryLanguages(user: String, repoName: String)

    private var method: HTTPMethod {
        switch self {
        case .fetchRepositories, .repositoryLanguages:
            return .get
        }
    }

    private var path: String {
        switch self {
        case .fetchRepositories:
            return "/search/repositories"
        case .repositoryLanguages(let user, let repoName):
            return "/repos/\(user)/\(repoName)/languages"
        }
    }

    private var headers: HTTPHeaders {
        switch self {
        case .fetchRepositories, .repositoryLanguages:
            return HTTPHeaders([
                HTTPHeader(name: Constants.HttpHeaderField.acceptType.rawValue,
                           value: Constants.ContentType.json.rawValue),
                HTTPHeader(name: Constants.HttpHeaderField.contentType.rawValue,
                           value: Constants.ContentType.json.rawValue)
            ])
        }
    }

    private var parameters: Parameters {
        switch self {
        case .fetchRepositories(let searchTerm, let sort, let order, let limit):
            return ["q": searchTerm,
                    "sort": sort.rawValue,
                    "order": order.rawValue,
                    "per_page": limit]
        case .repositoryLanguages:
            return Parameters()
        }
    }

    private var encoding: ParameterEncoding {
        switch self {
        case .fetchRepositories, .repositoryLanguages:
            return URLEncoding.default
        }
    }

    func asURLRequest() throws -> URLRequest {
        let baseUrl = try Constants.baseUrl.asURL()
        var urlRequest = URLRequest(url: baseUrl.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.headers = headers
        return try encoding.encode(urlRequest, with: parameters)
    }

}
