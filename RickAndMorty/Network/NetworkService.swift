//
//  NetworkService.swift
//  RickAndMorty
//
//  Created by Александра Кострова on 07.11.2023.
//

import Foundation

final class NetworkService {
    static let shared = NetworkService()

    enum DataType: String {
        case character, location, episode
    }

    private let baseUrl = "https://rickandmortyapi.com/api"

    // MARK: - Public Methods -
    func loadCharacterLocation(_ selectedCharacter: Character,
                               completion: @escaping (Location?) -> Void) {
        if let locationNumber = selectedCharacter.origin?.url?.split(separator: "/").last,
           let locationID = Int(locationNumber) {
            Task {
                do {
                    let locationInfo: Location =
                    try await getInfo(dataType: .location, id: locationID)
                    completion(locationInfo)
                } catch {
                    print("Ошибка декодирования данных: \(error)")
                    completion(nil)
                }
            }
        } else {
            completion(nil)
        }
    }

    func getEpisodes(_ episodes: [String], completion: @escaping ([Episode]) -> Void) {
        var sortedList: [Episode] = []

        loadEpisode(episodes) { episode in
            guard let episode else {
                return
            }
            sortedList.append(episode)

            if sortedList.count == episodes.count {
                completion(sortedList.sorted { $0.id < $1.id })
            }
        }
    }

    func getCharacters(page: Int, completion: @escaping (CharactersModel) -> Void) {
        loadCharacters(page: page, completion: completion)
    }

    // MARK: - Private Methods -
    private func loadEpisode(_ episodes: [String],
                             completion: @escaping (Episode?) -> Void)  {
        episodes.forEach { episodeURLString in
            if let episodeNumber = episodeURLString.split(separator: "/").last,
               let episodeID = Int(episodeNumber) {
                Task {
                    do {
                        let episode: Episode =
                        try await getInfo(dataType: .episode, id: episodeID)
                        completion(episode)
                    } catch {
                        print("Ошибка декодирования данных: \(error)")
                        completion(nil)
                    }
                }
            } else {
                completion(nil)
            }
        }
    }

    private func loadCharacters(page: Int,
                                completion: @escaping (CharactersModel) -> Void)  {
        Task {
            do {
                let characterModel: CharactersModel =
                try await getInfo(dataType: .character,page: page)
                completion(characterModel)
            } catch {
                print("Ошибка декодирования данных: \(error)")
            }
        }
    }

    /// Use with any NetworkModel, id could be character or something else ID
    private func getInfo<T: Decodable>(dataType: DataType,
                                      id: Int? = nil,
                                      page: Int? = nil) async throws -> T {
        var urlString = "\(baseUrl)/\(dataType.rawValue)"

        if let id {
            urlString += "/\(id)"
        }

        if let page {
            urlString += "?page=\(page)"
        }

        let url = URL(string: urlString)!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try decodeData(T.self, from: data)
    }

    /// Universal function to decode
    private func decodeData<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}
