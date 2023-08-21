//
//  InfoAndHeadersCell.swift
//  RickAndMorty
//
//  Created by Александра Кострова on 21.08.2023.
//

import UIKit

class InfoAndHeadersCell: UITableViewCell {
        
    static let identifier = "InfoAndHeadersCell"

    private lazy var infoLabel: UILabel = {
        let label = WhiteSemiBoldLabel(name: "Info")
        return label
    }()
    
    private lazy var originLabel: UILabel = {
        let label = WhiteSemiBoldLabel(name: "Origin")
        return label
    }()
    
    private lazy var episodesLabel: UILabel = {
        let label = WhiteSemiBoldLabel(name: "Episodes")
        return label
    }()
    
    private lazy var infoStackView: UIStackView = {
        let stackView = InfoStackView()
        return stackView
    }()
    
    private lazy var originView: UIView = {
        let view = OriginView()
        return view
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 16
        stackView.addSomeSubviews([infoLabel, infoStackView,
                              originLabel, originView,
                              episodesLabel])
        return stackView
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
        
        self.addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: self.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                   constant: Constants.Constraints.profileSideGap),
            mainStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                    constant: -Constants.Constraints.profileSideGap),

            infoLabel.bottomAnchor.constraint(equalTo: infoStackView.topAnchor,
                                               constant: -Constants.Constraints.profileVerticalGap),
            infoStackView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            infoStackView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            infoStackView.bottomAnchor.constraint(equalTo: originLabel.topAnchor,
                                               constant: -Constants.Constraints.profileVerticalGap),
            
            originLabel.heightAnchor.constraint(equalTo: infoLabel.heightAnchor),
            originLabel.bottomAnchor.constraint(equalTo: originView.topAnchor,
                                                constant: -Constants.Constraints.profileVerticalGap),
            originView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            originView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor),
            originView.bottomAnchor.constraint(equalTo: episodesLabel.topAnchor,
                                               constant: -Constants.Constraints.profileVerticalGap),

            episodesLabel.heightAnchor.constraint(equalTo: infoLabel.heightAnchor)
        ])
    }
}
