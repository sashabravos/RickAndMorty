//
//  ProfileCell.swift
//  RickAndMorty
//
//  Created by Alexandra on 08.12.2023.
//

import UIKit

class ProfileCell: UITableViewCell {

    @IBOutlet weak var characterImage: UIImageView!
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var stateOfLife: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configureCell(model: Character?) {
        guard let model else {
            return
        }
        characterName.text = model.name
        stateOfLife.text = model.status

        let imageURL = URL(string: model.image ?? String())
        characterImage.layer.cornerRadius = 16
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
