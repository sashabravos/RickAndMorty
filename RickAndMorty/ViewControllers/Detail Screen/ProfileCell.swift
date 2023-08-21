//
//  ProfileCell.swift
//  RickAndMorty
//
//  Created by Александра Кострова on 21.08.2023.
//

import UIKit

class ProfileCell: UITableViewCell {
        
    static let identifier = "ProfileCell"

    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = Constants.CornerRadius.profileImage
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "rick")
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Font.profileName
        label.textColor = Constants.Color.white
        label.text = "Rick Sanchez"
        return label
    }()
    
    private lazy var stateOfLifeLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Font.stateOfLife
        label.textColor = Constants.Color.primary
        label.contentMode = .top
        label.text = "Alive"
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = Constants.Constraints.profileVerticalGap
        stackView.addSomeSubviews([profileImageView, nameLabel, stateOfLifeLabel])
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
        
        self.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor,
                                              constant: -Constants.Constraints.profileVerticalGap),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            profileImageView.heightAnchor.constraint(equalToConstant: Constants.Constraints.cardImageSquareSize),
            profileImageView.widthAnchor.constraint(equalTo: profileImageView.heightAnchor)
        ])
    }
}
