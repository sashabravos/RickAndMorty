//
//  CharactersViewModel.swift
//  RickAndMorty
//
//  Created by Александра Кострова on 18.11.2023.
//

import Combine
import Foundation

final class CharactersViewModel {
    // MARK: - Properties -
    var characters: [Character] = []
    var hasNextPage = true
    var reloadSubject: PassthroughSubject<Void, Never> = .init()

    private var currentPage = 1
    private var cancellables = Set<AnyCancellable>()
    private let service = NetworkService.shared

    // MARK: - Methods -
    func loadCharacters() {
        guard hasNextPage else {
            return
        }
        
        service.getCharacters(page: currentPage) { [weak self] in
            self?.appendCharacters($0.results, $0.info)
            self?.reloadSubject.send()
        }
    }

    private func appendCharacters(_ charactersInfo: [Character],
                                  _ pageInfo: Info) {
        characters.append(contentsOf: charactersInfo)

        guard pageInfo.next != nil else {
            hasNextPage = false
            return
        }
        currentPage += 1
    }
}
