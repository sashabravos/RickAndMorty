//
//  String+Extension.swift
//  RickAndMorty
//
//  Created by Александра Кострова on 23.08.2023.
//

import Foundation
import UIKit

extension String {
    init(_ constant: StringConstants) {
        self.init(constant.rawValue)
    }

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

enum StringConstants: String {
    static let noInfo = "Unknown"

    case info = "Info"
    case species = "Species:"
    case type = "Type:"
    case gender = "Gender:"
    case origin = "Origin"

    case charactersTitle = "Characters"

    case characterCellName = "CharacterCell"
    case profileCellName = "ProfileCell"
}
