//
//  InfoCell.swift
//  RickAndMorty
//
//  Created by Alexandra on 08.12.2023.
//

import UIKit

class InfoCell: UITableViewCell {
    @IBOutlet weak var infoStackView: UIStackView!
    @IBOutlet weak var speciesLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }

    private func setupCell() {
        infoStackView.layer.cornerRadius = 16
        infoStackView.layer.masksToBounds = true
    }

    func configureCell(character: Character?) {
        guard let character else {
            return
        }
        speciesLabel.text = character.species ?? .noInfo
        genderLabel.text =  character.gender ?? .noInfo

        let type = character.type
        guard type == "" || type == nil else {
            typeLabel.text = type
            return
        }
        typeLabel.text = .noInfo
    }
}
