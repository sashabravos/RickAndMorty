//
//  CharacterCard.swift
//  RickAndMorty
//
//  Created by Александра Кострова on 20.08.2023.
//

import UIKit
import Kingfisher

final class CharacterCard: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let identifier = "CharacterCell"
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = Constants.CornerRadius.cardImage
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Font.characterCardName
        label.textColor = Constants.Color.white
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupViews() {
        
        [imageView, titleLabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                           constant: Constants.Constraints.cardImageBorderGap),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                               constant: Constants.Constraints.cardImageBorderGap),
            imageView.heightAnchor.constraint(equalToConstant: Constants.Constraints.cardImageSquareSize),
            imageView.widthAnchor.constraint(equalToConstant: Constants.Constraints.cardImageSquareSize),
            
            titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor,
                                                constant: Constants.Constraints.cardImageBorderGap),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor,
                                                 constant: -Constants.Constraints.cardImageBorderGap),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor,
                                            constant: Constants.Constraints.cardTitleTop),
            titleLabel.heightAnchor.constraint(equalToConstant: Constants.Constraints.cardTitleHeight)
        ])
    }
    
    // MARK: - Public Methods
    
    public func configure(with model: Character) {
        self.layer.cornerRadius = Constants.CornerRadius.cellCard
        self.layer.masksToBounds = true
        self.backgroundColor = Constants.Color.blackCard
        
        titleLabel.text = model.name
        let imageURL = URL(string: model.image ?? String())
        
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
            with: imageURL,
            options: [
                .scaleFactor(UIScreen.main.scale),
                .cacheOriginalImage
            ]
        )
    }
}
