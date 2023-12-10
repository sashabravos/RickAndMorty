//
//  String+Extension.swift
//  RickAndMorty
//
//  Created by Александра Кострова on 23.08.2023.
//

import Foundation
import UIKit

extension String {
    /// Convert "S01E06" format to "Episode 6, Season1"
    func convertToEpisodeTitle() -> String {
        let components = self.components(separatedBy: "E")
        guard components.count == 2,
              let seasonNumber = Int(components[0].replacingOccurrences(of: "S", with: "")),
              let episodeNumber = Int(components[1])
        else {
            return self
        }

        return "Episode \(episodeNumber), Season \(seasonNumber)"
    }
}

// MARK: - StringConstants -
extension String {
    static let noInfo = "Unknown"

    static let characterCellName = "CharacterCell"
    static let profileCellName = "ProfileCell"
    static let infoCellName = "InfoCell"
    static let originCellName = "OriginCell"
    static let episodesCellName = "EpisodesCell"

    static let info = "Info"
    static let species = "Species:"
    static let type = "Type:"
    static let gender = "Gender:"
    static let origin = "Origin"

    static let charactersTitle = "Characters"
}
