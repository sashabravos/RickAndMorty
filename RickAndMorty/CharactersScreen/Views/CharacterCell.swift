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

        self.layer.cornerRadius = 16
    }

    func configureCell(model: Character) {
        nameLabel.font = Constants.Fonts.characterCardName
        nameLabel.text = model.name

        let url = URL(string: model.image ?? "")
        let processor = DownsamplingImageProcessor(size: characterImage.bounds.size)
        |> RoundCornerImageProcessor(cornerRadius: 10)
        characterImage.kf.indicatorType = .activity
        characterImage.kf.setImage(
            with: url,
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ]
        )
    }
}
