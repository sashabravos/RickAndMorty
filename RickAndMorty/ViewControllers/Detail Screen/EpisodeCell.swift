//
//  EpisodeCell.swift
//  RickAndMorty
//
//  Created by Александра Кострова on 21.08.2023.
//

import UIKit

class EpisodeCell: UITableViewCell {
        
    static let identifier = "EpisodeCell"

    private lazy var titleLabel: UILabel = {
        let label = WhiteSemiBoldLabel(name: "Pilot")
        return label
    }()
        
    private lazy var episodeFeatures: UILabel = {
        let label = SmallGreenLabel(name: "Episode 1, Season 1")
        return label
    }()
    
    private lazy var episodeDate: UILabel = {
        let label = UILabel()
        label.font = Constants.Font.descriptionRight
        label.textColor = Constants.Color.textSecondary
        label.text = "December 13, 2013"
        return label
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = Constants.Color.blackCard
        view.layer.cornerRadius = Constants.CornerRadius.profileAnyCard
        [titleLabel, episodeFeatures, episodeDate].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func setupViews() {
        self.backgroundColor = Constants.Color.blackBG
        self.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalToConstant: Constants.Constraints.episodeCardHeight),
            containerView.topAnchor.constraint(equalTo: self.topAnchor,
                                               constant: Constants.Constraints.profileVerticalGap),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                   constant: Constants.Constraints.profileSideGap),
            containerView.trailingAnchor.constraint(equalTo:
                                                        self.trailingAnchor,
                                                    constant: -Constants.Constraints.profileSideGap),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor,
                                            constant: Constants.Constraints.profileVerticalGap),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,
                                                constant: Constants.Constraints.profileSideGap),

            episodeFeatures.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            episodeFeatures.bottomAnchor.constraint(equalTo: containerView.bottomAnchor,
                                                    constant: -Constants.Constraints.profileSideGap),

            episodeDate.bottomAnchor.constraint(equalTo: episodeFeatures.bottomAnchor),
            episodeDate.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,
                                                  constant: -Constants.Constraints.profileSideGap)
        ])
    }
}
