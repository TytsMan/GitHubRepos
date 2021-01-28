//
//  SearchingReposistoriesController.swift
//  GitHubRepos
//
//  Created by Ivan Dekhtiarov on 24.01.2021.
//  Copyright © 2021 Ivan Dekhtiarov. All rights reserved.
//

import UIKit
import PureLayout
import RealmSwift

final class SearchingReposistoriesController: UIViewController {

    lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .init(top: 10, left: 10, bottom: 10, right: 10)
        layout.scrollDirection = .vertical
        return layout
    }()

    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.contentInsetAdjustmentBehavior = .always
        return collectionView
    }()

    lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.sizeToFit()
        searchController.searchBar.tintColor = .white
        searchController.searchBar.barStyle = .black
        searchController.searchBar.scopeButtonTitles = RepositoriesSort.allCases.map { $0.readable }
        searchController.searchBar.setScopeBarButtonTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.143222779, green: 0.1625339985, blue: 0.1780804992, alpha: 1)], for: .selected)
        searchController.searchBar.setScopeBarButtonTitleTextAttributes(
            [NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
        return searchController
    }()

    private var didSetupConstraints = false
    var networkService: NetworkService!
    var searchResults: Results<SearchResult>?
    var searchResult: SearchResult? {
        didSet {
            collectionView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func updateViewConstraints() {
        if !didSetupConstraints {
            NSLayoutConstraint.autoSetIdentifier("collection view constraint") {
                collectionView.autoPinEdge(toSuperviewSafeArea: .top)
                collectionView.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .top)
            }
            didSetupConstraints = true
        }
        super.updateViewConstraints()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    // MARK: - Private
    func setupView() {
        navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 0.143222779, green: 0.1625339985, blue: 0.1780804992, alpha: 1)
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.143222779, green: 0.1625339985, blue: 0.1780804992, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes =
            [NSAttributedString.Key.foregroundColor: UIColor.white]
        view.backgroundColor = .white
        view.tintColor = .orange
        view.backgroundColor = #colorLiteral(red: 1, green: 0.9662379622, blue: 0.965716064, alpha: 1)
        definesPresentationContext = true
        extendedLayoutIncludesOpaqueBars = true
        navigationItem.searchController = searchController
        title = "Repositories" // consts, yeah
        searchController.searchBar.placeholder = "Enter repo name"

        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self

        collectionView.register(GitRepositoryCell.self,
                                forCellWithReuseIdentifier: String(describing: GitRepositoryCell.self))
        collectionView.delegate = self
        collectionView.dataSource = self

        view.addSubview(collectionView)
        view.setNeedsUpdateConstraints()

        guard let realm = try? Realm() else {
            return
        }
        let results = realm.objects(SearchResult.self)
        self.searchResults = results

    }

    private func fetchRepos() {

        let searchBar = searchController.searchBar
        let sorting = RepositoriesSort.allCases[searchBar.selectedScopeButtonIndex]
        guard
            let searchTerm = searchBar.text,
            !searchTerm.isEmpty
            else {
                return
        }

        if let result = searchResults?.filter({ $0.searchTerm == searchTerm && $0.sorting == sorting.rawValue }).first {
            searchResult = result
        } else {

            networkService.fetchRepos(searchTerm: searchTerm, sorting: sorting, order: .desc) { [weak self](response) in
                switch response {
                case .failure(let error):
                    print(error.localizedDescription)

                case .success(let result):
                    let searchResult = SearchResult()
                    searchResult.searchTerm = searchTerm
                    searchResult.sorting = sorting.rawValue
                    searchResult.order = Order.desc.rawValue

                    guard let realm = try? Realm() else {
                        return
                    }
                    try? realm.write {
                        result.items.map(Repository.init).forEach { (repository) in
                            realm.add(repository, update: .modified)
                            searchResult.items.append(repository)
                        }
                        realm.add(searchResult)
                    }
                    self?.searchResult = searchResult

                    //                 request limit 60, потрачено
                    /*DispatchQueue.concurrentPerform(iterations: result.items.count) { [weak self](iteration) in
                        guard let weakSelf = self else { return }
                        let repo = weakSelf.repositories[iteration]
                        weakSelf.networkService.getRepoLanguages(user: repo.owner.login,
                                                                 repoName: repo.name) { (responseLanguages) in
                                                                    switch responseLanguages {
                                                                    case .failure(let error):
                                                                        print(error.localizedDescription)
                                                                    case .success(let languages):
                                                                        if languages.count > 1 {
                                                                            weakSelf.repositories[iteration].language =
                                                                                languages.reduce("", { (res, dict) -> String in
                                                                                    return res + (res.isEmpty ? "" : ", ") + dict.key
                                                                                })
                                                                        }
                                                                    }
                        }
                    }*/
                }
            }

        }
    }

}

// MARK: - UISearchResultsUpdating
extension SearchingReposistoriesController: UISearchResultsUpdating {

    func updateSearchResults(for searchController: UISearchController) {
        fetchRepos()
    }

}

// MARK: - UISearchBarDelegate
extension SearchingReposistoriesController: UISearchBarDelegate {

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchResult = nil
    }

}

// MARK: - UICollectionViewDataSource
extension SearchingReposistoriesController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return searchResult?.items.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: String(describing: GitRepositoryCell.self),
                for: indexPath) as? GitRepositoryCell,
            let repository = searchResult?.items[indexPath.row]
            else {
                fatalError("Can't dequeue cell with type GitRepositoryCell")
        }
        cell.configure(with: repository)
        return cell
    }

}

// MARK: - UICollectionViewDelegate
extension SearchingReposistoriesController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let repository = searchResult?.items[indexPath.row] else {
            return
        }
        let repoDetail = RepositoryDetailController()
        repoDetail.confugire(with: repository)
        navigationController?.pushViewController(repoDetail, animated: true)
    }

}

// MARK: - UICollectionViewDelegateFlowLayout
extension SearchingReposistoriesController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sectionInset = (collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset ?? UIEdgeInsets.zero
        let referenceHeight: CGFloat = 130
        let referenceWidth = collectionView.safeAreaLayoutGuide.layoutFrame.width
            - sectionInset.left
            - sectionInset.right
            - collectionView.contentInset.left
            - collectionView.contentInset.right
        return CGSize(width: referenceWidth, height: referenceHeight)
    }

}
