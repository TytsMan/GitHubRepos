//
//  GitRepositoryCell.swift
//  GitHubRepos
//
//  Created by Ivan Dekhtiarov on 24.01.2021.
//  Copyright © 2021 Ivan Dekhtiarov. All rights reserved.
//

import UIKit
import PureLayout

final class GitRepositoryCell: UICollectionViewCell {

    private lazy var repoNameLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Repo Name Label"
        label.font = .boldSystemFont(ofSize: 20)
        return label

    }()

    private lazy var fullRepoNameLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Full Repo Name Label"
        label.textColor = .gray
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 13)
        return label
    }()

    private lazy var repoLanguagesLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "repo Languages label"
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.font = .preferredFont(forTextStyle: .footnote)
        return label
    }()

    private lazy var starredCounterLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.text = "999+ K"
        return label
    }()

    private lazy var forkedCounterLabel: UILabel = {
        let label = UILabel.newAutoLayout()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.text = "999+ K"
        return label
    }()

    private lazy var starImage: UIImageView = {
        let imageView = UIImageView.newAutoLayout()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "star.png")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var forkImage: UIImageView = {
        let imageView = UIImageView.newAutoLayout()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "fork.png")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var firstLineCounterStark: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [starredCounterLabel, starImage])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = itemSpacing.left
        stack.distribution = .equalSpacing
        return stack
    }()

    private lazy var secondLineCounterStark: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [forkedCounterLabel, forkImage])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = itemSpacing.left
        stack.distribution = .equalSpacing
        return stack
    }()

    private lazy var counterStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: counterStacks)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = itemSpacing.left
        stack.distribution = .equalCentering
        return stack
    }()

    private var didSetupConstraints = false
    private lazy var rightSileLabels = [starredCounterLabel, forkedCounterLabel]
    private lazy var leftSideLabels = [repoNameLabel, fullRepoNameLabel, repoLanguagesLabel]
    private lazy var images = [starImage, forkImage]
    private lazy var counterStacks = [firstLineCounterStark, secondLineCounterStark]

    private lazy var edgesInsets: UIEdgeInsets = .init(top: 10, left: 10, bottom: 10, right: 10)
    private lazy var itemSpacing: UIEdgeInsets = .init(top: 4, left: 4, bottom: 4, right: 4)
    private lazy var rightSideLabelsMaxWidth: CGFloat = 64.0
    private lazy var leftSileLabelsMaxWidth: CGFloat =
        UIScreen.main.bounds.width
            - rightSideLabelsMaxWidth
            - (edgesInsets.left * 5) // spacing Magic
    let imageSize = CGSize(width: 20, height: 20)

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateConstraints() {
        // swiftlint:disable line_length
        if !didSetupConstraints {

            contentView.translatesAutoresizingMaskIntoConstraints = false
            contentView.autoPinEdgesToSuperviewEdges(with: .zero) // doesn't works???

            NSLayoutConstraint.autoSetIdentifier("counter constraint") {
                (images as NSArray).autoSetViewsDimensions(to: imageSize)
                (rightSileLabels as NSArray).autoSetViewsDimension(.width, toSize: rightSideLabelsMaxWidth)
                (counterStacks as NSArray).autoSetViewsDimension(.width,
                                                                 toSize: rightSideLabelsMaxWidth
                                                                    + imageSize.width
                                                                    + itemSpacing.left)
                counterStack.autoAlignAxis(toSuperviewAxis: .horizontal)
                counterStack.autoPinEdge(toSuperviewEdge: .right, withInset: edgesInsets.right)
            }

            NSLayoutConstraint.autoSetIdentifier("repo name label constraint") {
                repoNameLabel.autoPinEdge(toSuperviewEdge: .top, withInset: edgesInsets.top, relation: .equal)
                repoNameLabel.autoPinEdge(toSuperviewEdge: .left, withInset: edgesInsets.left, relation: .equal)
                repoNameLabel.autoPinEdge(toSuperviewEdge: .right, withInset: edgesInsets.right, relation: .greaterThanOrEqual)
            }

            NSLayoutConstraint.autoSetIdentifier("full repo name label constraint") {
                fullRepoNameLabel.autoPinEdge(.top, to: .bottom, of: repoNameLabel, withOffset: itemSpacing.top)
                fullRepoNameLabel.autoPinEdge(toSuperviewEdge: .left, withInset: edgesInsets.left, relation: .equal)
                fullRepoNameLabel.autoPinEdge(.right, to: .left, of: counterStack, withOffset: -itemSpacing.right, relation: .lessThanOrEqual)
            }

            NSLayoutConstraint.autoSetIdentifier("repo languages label constraint") {
                repoLanguagesLabel.autoPinEdge(toSuperviewEdge: .left, withInset: edgesInsets.left, relation: .equal)
                repoLanguagesLabel.autoPinEdge(toSuperviewEdge: .bottom, withInset: edgesInsets.bottom, relation: .equal)
                repoLanguagesLabel.autoPinEdge(.right, to: .left, of: counterStack, withOffset: -itemSpacing.right)
                repoLanguagesLabel.autoPinEdge(.top, to: .bottom, of: fullRepoNameLabel, withOffset: 0, relation: .greaterThanOrEqual)
            }

            didSetupConstraints = true
        }

        super.updateConstraints()
        // swiftlint:enable line_length
    }

    // MARK: - Public
    func configure(with repo: Repository) {
        repoNameLabel.text = repo.name
        fullRepoNameLabel.text = repo.fullName
        repoLanguagesLabel.text = repo.language
        starredCounterLabel.text = format(counter: repo.stargazersCount)
        forkedCounterLabel.text = format(counter: repo.forksCount)
    }

    // MARK: - Private
    private func setupView() {
        layer.cornerRadius = 16
        layer.masksToBounds = true
        layer.shadowOffset = CGSize(width: 1.5, height: 4.0)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.8
        layer.backgroundColor = UIColor.white.cgColor

        contentView.addSubview(counterStack)
        contentView.addSubview(repoNameLabel)
        contentView.addSubview(fullRepoNameLabel)
        contentView.addSubview(repoLanguagesLabel)
        contentView.setNeedsUpdateConstraints()
    }

}

// MARK: - Supporting functions
extension GitRepositoryCell {

    fileprivate func format(counter: Int) -> String {
        if counter > 100000 {
            return "999+ K"
        } else if counter < 1000 {
            return "\(counter)"
        } else {
            return "\(counter/1000) K"
        }
    }

}
