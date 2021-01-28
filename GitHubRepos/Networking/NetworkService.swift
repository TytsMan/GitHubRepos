//
//  RequestService.swift
//  GitHubRepos
//
//  Created by Ivan Dekhtiarov on 24.01.2021.
//  Copyright © 2021 Ivan Dekhtiarov. All rights reserved.
//

import Foundation
import Alamofire

class NetworkService {

    func fetchRepos(searchTerm: String,
                    sorting: RepositoriesSort,
                    order: Order,
                    completionHandler: @escaping (Result<SearchResultWrapperTDO<RepositoryTDO>, Error>) -> Void) {
        NetworkService.request(
            GitHubEndPoint.fetchRepositories(searchTerm: searchTerm,
                                             sort: sorting,
                                             order: order,
                                             limit: 30),
            completionHandler: completionHandler)
    }

    func getRepoLanguages(user: String,
                          repoName: String,
                          completionHandler: @escaping (Result<[String: Int], Error>) -> Void) {
        NetworkService.request(
            GitHubEndPoint.repositoryLanguages(user: user,
                                        repoName: repoName),
            completionHandler: completionHandler)
    }

    private static func request<T: Codable>(_ urlConvertible: URLRequestConvertible,
                                            completionHandler: @escaping (Result<T, Error>) -> Void) {

        AF.request(urlConvertible)
            .validate()
            .responseDecodable(of: T.self) { (response) in

                switch response.result {
                case .failure(let error):
                    completionHandler(.failure(error))

                case .success(let value):
                    completionHandler(.success(value))

                }

        }

    }

}
