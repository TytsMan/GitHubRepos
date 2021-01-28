//
//  DetailCell.swift
//  GitHubRepos
//
//  Created by Ivan Dekhtiarov on 26.01.2021.
//  Copyright © 2021 Ivan Dekhtiarov. All rights reserved.
//

import UIKit
import PureLayout

final class DetailCell: UITableViewCell {

    private var didSetupConstraints = false
    private var propertyName: String? {
        didSet {
            propertyNameLabel.text = propertyName
        }
    }
    private var propertyValue: String? {
        didSet {
            propertyValueLabel.text = propertyValue
        }
    }

    lazy var propertyNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "propertyNameLabel"
        label.numberOfLines = 0
        return label
    }()

    lazy var propertyValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "propertyValueLabel"
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateConstraints() {

        if !didSetupConstraints {

            let propertyNameLabelInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
            propertyNameLabel.autoPinEdgesToSuperviewEdges(with: propertyNameLabelInsets, excludingEdge: .bottom)

            let propertyValueLabelInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
            propertyValueLabel.autoPinEdgesToSuperviewEdges(with: propertyValueLabelInsets, excludingEdge: .top)

            propertyValueLabel.autoPinEdge(.top,
                                           to: .bottom,
                                           of: propertyNameLabel,
                                           withOffset: propertyValueLabelInsets.top)

            didSetupConstraints = true
        }

        super.updateConstraints()
    }

    // MARK: - Public
    func configure(property name: String, value: String) {
        self.propertyName = name
        self.propertyValue = value
    }

    // MARK: - Private
    private func setupView() {
        contentView.addSubview(propertyNameLabel)
        contentView.addSubview(propertyValueLabel)
        contentView.setNeedsUpdateConstraints()
    }

}
