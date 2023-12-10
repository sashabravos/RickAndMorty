//
//  EpisodesCell.swift
//  RickAndMorty
//
//  Created by Alexandra on 08.12.2023.
//

import UIKit

class EpisodesCell: UITableViewCell {

    @IBOutlet weak var episodeView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var episodeFeatures: UILabel!
    @IBOutlet weak var episodeDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        episodeView.layer.cornerRadius = 16
    }

    func configureCell(model: Episode?) {
        guard let model else {
            return
        }

        titleLabel.text = model.name
        episodeFeatures.text = model.episode?.convertToEpisodeTitle()
        episodeDate.text = model.airDate
    }
}
