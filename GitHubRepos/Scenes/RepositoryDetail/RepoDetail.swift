//
//  ViewController.swift
//  GitHubRepos
//
//  Created by Ivan Dekhtiarov on 25.01.2021.
//  Copyright © 2021 Ivan Dekhtiarov. All rights reserved.
//

import UIKit
import PureLayout

class RepositoryDetail: UIViewController {

    private var didSetupConstraints = false
    private var repository: Repository?

    private lazy var tableView: UITableView = {
        let tableView = UITableView.newAutoLayout()
        tableView.backgroundColor = .clear
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func loadView() {
        setupView()
    }

    override func updateViewConstraints() {
        if !didSetupConstraints {
            tableView.autoPinEdgesToSuperviewEdges()

            didSetupConstraints = true
        }
        super.updateViewConstraints()
    }

    // MARK: - Public
    func confugire(with repository: Repository) {
        self.repository = repository
    }

    // MARK: - Private
    private func setupView() {
        view.addSubview(tableView)
        view.setNeedsUpdateConstraints()
    }
}

extension RepositoryDetail: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
