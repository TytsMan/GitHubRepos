//
//  RepositoryDetailController.swift
//  GitHubRepos
//
//  Created by Ivan Dekhtiarov on 25.01.2021.
//  Copyright © 2021 Ivan Dekhtiarov. All rights reserved.
//

import UIKit
import PureLayout

final class RepositoryDetailController: UIViewController {

    private var repository: Repository? {
        didSet {
            tableView.reloadData()
        }
    }

    private lazy var tableView: UITableView = {
        let tableView = UITableView.newAutoLayout()
        tableView.backgroundColor = .clear
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func updateViewConstraints() {
        if !didSetupConstraints {
            tableView.autoPinEdgesToSuperviewEdges()

            didSetupConstraints = true
        }
        super.updateViewConstraints()
    }

    private var didSetupConstraints = false

    // MARK: - Public
    func confugire(with repository: Repository) {
        self.repository = repository
    }

    // MARK: - Private
    private func setupView() {
        view.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .white

        tableView.register(DetailCell.self, forCellReuseIdentifier: String(describing: DetailCell.self))
        tableView.dataSource = self

        view.addSubview(tableView)
        view.setNeedsUpdateConstraints()
    }

}

// MARK: - UITableViewDataSource
extension RepositoryDetailController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repository != nil ? 7 : 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DetailCell.self),
                                                     for: indexPath) as? DetailCell,
            let repository = repository
            else {
                fatalError("Can't dequeue cell type DetailCell")
        }

        switch indexPath.row {
        case 0:
            cell.configure(property: "name", value: repository.name)
        case 1:
            cell.configure(property: "fullName", value: repository.fullName)
        case 2:
            cell.configure(property: "description", value: repository.itemDescription )
        case 3:
            cell.configure(property: "language", value: repository.language)
        case 4:
            cell.configure(property: "url", value: repository.url)
        case 5:
            cell.configure(property: "owner", value: repository.owner?.login ?? "")
        case 6:
            cell.configure(property: "homepage", value: repository.homepage)
        default:
            cell.configure(property: "-", value: "-")
        }

        return cell
    }

}
