//
//  ProfileViewModel.swift
//  RickAndMorty
//
//  Created by Александра Кострова on 18.11.2023.
//

import Combine
import Foundation

final class ProfileViewModel: ObservableObject {
    @Published var episodes: [Episode] = []
    var character: Character
    var location: Location?

    init(_ character: Character) {
        self.character = character
    }
    private let service = NetworkService.shared

    func getCharacterEpisodes() {
        if let episodesList = character.episode {
            DispatchQueue.main.async { [weak self] in
                self?.service.getEpisodes(episodesList) {
                    self?.episodes = $0
                }
            }
        }
    }

    func loadCharacterLocation(_ character: Character) {
        service.loadCharacterLocation(character) { [weak self] in
            self?.location = $0
        }
    }
}
