//
//  NetworkService.swift
//  RickAndMorty
//
//  Created by Александра Кострова on 07.11.2023.
//

import Foundation

class NetworkService {
    static let shared = NetworkService()

    func loadCharacterLocation(_ selectedCharacter: Character,
                               completion: @escaping (Location?) -> Void) {
        if let locationNumber = selectedCharacter.origin?.url?.split(separator: "/").last,
           let locationID = Int(locationNumber) {
            Task {
                do {
                    let locationInfo: Location =
                    try await RequestManager.shared.getInfo(dataType: .location, id: locationID)
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

    private func loadEpisode(_ episodes: [String],
                     completion: @escaping (Episode?) -> Void)  {
        episodes.forEach { episodeURLString in
            if let episodeNumber = episodeURLString.split(separator: "/").last,
               let episodeID = Int(episodeNumber) {
                Task {
                    do {
                        let episode: Episode =
                        try await RequestManager.shared.getInfo(dataType: .episode, id: episodeID)
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
}