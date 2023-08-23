//
//  CharactersViewModel.swift
//  RickAndMorty
//
//  Created by Александра Кострова on 18.11.2023.
//

import Combine
import Foundation

final class CharactersViewModel: ObservableObject {
    // MARK: - Published properties -
    @Published var characters: [Character] = []
    @Published var episodes: [Episode] = []

    var profileViewSubject: PassthroughSubject<ProfileView, Never> = .init()

    // MARK: - Private Properties -
    private let service = NetworkService.shared
    private var cancellables = Set<AnyCancellable>()
    var episodesList: [String] = []
    var originURL = ""
    var currentPage = 1
    var isLoadingData = false

    // MARK: - Initialisation -
    init() {
        episodes.removeAll()
    }

    // MARK: - Methods -
    func presentProfileView(_ character: Character) {
        let detailScreen = ProfileView(characterModel: character,
                                       locationModel: character.location)
        profileViewSubject.send(detailScreen)
    }

    func loadCharacters() {
        service.getCharacters(page: currentPage) { [weak self] in
            self?.appendCharacters($0.results, $0.info)
        }
    }

    private func appendCharacters(_ charactersInfo: [Character],
                                  _ pageInfo: Info) {
        characters.append(contentsOf: charactersInfo)

        if pageInfo.next != nil {
            currentPage += 1
            isLoadingData = false
        }
    }
}
