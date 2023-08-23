//
//  String+Extension.swift
//  RickAndMorty
//
//  Created by Александра Кострова on 23.08.2023.
//

import Foundation

extension String {
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
