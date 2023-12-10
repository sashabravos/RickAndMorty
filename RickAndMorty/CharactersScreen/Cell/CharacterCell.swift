//
//  CharacterCell.swift
//  RickAndMorty
//
//  Created by Alexandra on 06.12.2023.
//

import UIKit
import Kingfisher

final class CharacterCell: UICollectionViewCell {
    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    private func setupCell() {
        self.layer.cornerRadius = 16
        characterImage.layer.cornerRadius = 10
    }
    
    func configureCell(model: Character) {
        nameLabel.font = Constants.Fonts.characterCardName
        nameLabel.text = model.name
        
        let imageURL = URL(string: model.image ?? String())
        
        characterImage.kf.indicatorType = .activity
        characterImage.kf.setImage(
            with: imageURL,
            options: [
                .scaleFactor(UIScreen.main.scale),
                .cacheOriginalImage
            ]
        )
    }
}
