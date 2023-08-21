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
//        label.backgroundColor = .clear
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
        
        self.layer.cornerRadius = 16
        self.layer.masksToBounds = true
        self.backgroundColor = #colorLiteral(red: 0.1976234317, green: 0.219899714, blue: 0.2836517096, alpha: 1)
        
        [imageView, titleLabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8.0),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8.0),
            imageView.heightAnchor.constraint(equalToConstant: 140.0),
            imageView.widthAnchor.constraint(equalToConstant: 140.0),
            
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 164.0),
            titleLabel.heightAnchor.constraint(equalToConstant: 22)
        ])
    }
    
    func configure(with image: UIImage, title: String) {
        imageView.image = image
        titleLabel.text = title
    }
}
