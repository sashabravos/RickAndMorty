//
//  CharacterCard.swift
//  RickAndMorty
//
//  Created by Александра Кострова on 20.08.2023.
//

import UIKit

final class CharacterCard: UICollectionViewCell {
    
    static let identifier = "CharacterCell"
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = Constants.CornerRadius.cardImage
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.Font.characterCardName
        label.textColor = Constants.Color.white
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        
        self.layer.cornerRadius = Constants.CornerRadius.cellCard
        self.layer.masksToBounds = true
        self.backgroundColor = Constants.Color.blackCard
        
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
            
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor,
                                            constant: Constants.Constraints.cardTitleTop),
            titleLabel.heightAnchor.constraint(equalToConstant: Constants.Constraints.cardTitleHeight)
        ])
    }
    
    func configure(with image: UIImage, title: String) {
        imageView.image = image
        titleLabel.text = title
    }
}
