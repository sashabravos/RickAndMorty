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
    var profileViewSubject: PassthroughSubject<ProfileView, Never> = .init()

    // MARK: - Private Properties -
    private let service = NetworkService.shared
    private var currentPage = 1
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Methods -
    func presentProfileView(_ character: Character) {
        let detailScreen = ProfileView(viewModel: .init(character))
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
        }
    }
}
