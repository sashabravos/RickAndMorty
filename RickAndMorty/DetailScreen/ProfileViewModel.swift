//
//  ProfileViewModel.swift
//  RickAndMorty
//
//  Created by Александра Кострова on 18.11.2023.
//

import Combine
import Foundation

final class ProfileViewModel {
    var episodes: [Episode] = []
    var character: Character?
    var location: Location?
    var reloadSubject: PassthroughSubject<Void, Never> = .init()

    init(_ character: Character?) {
        self.character = character

        getCharacterEpisodes()
        loadCharacterLocation()
    }
    private let service = NetworkService.shared

    func getCharacterEpisodes() {
        guard let character else {
            return
        }

        if let episodesList = character.episode {
            DispatchQueue.main.async { [weak self] in
                self?.service.getEpisodes(episodesList) {
                    self?.episodes = $0
                }
            }
        }
        reloadSubject.send()
    }

    private func loadCharacterLocation() {
        guard let character else {
            return
        }
        service.loadCharacterLocation(character) { [weak self] in
            self?.location = $0
        }
        reloadSubject.send()
    }
}
