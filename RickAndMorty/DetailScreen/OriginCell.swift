//
//  OriginCell.swift
//  RickAndMorty
//
//  Created by Alexandra on 08.12.2023.
//

import UIKit

class OriginCell: UITableViewCell {
    @IBOutlet weak var planetName: UILabel!
    @IBOutlet weak var planetType: UILabel!
    @IBOutlet weak var planetView: UIView!
    @IBOutlet weak var originView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }

    private func setupCell() {
        planetView.layer.cornerRadius = 10
        planetView.layer.masksToBounds = true

        originView.layer.cornerRadius = 16
        originView.layer.masksToBounds = true
    }

    func configureCell(location: Location?) {
        planetName.text = location?.name ?? .noInfo
        planetType.text = location?.type ?? .noInfo
    }
}
