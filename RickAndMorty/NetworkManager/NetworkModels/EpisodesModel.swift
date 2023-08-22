//
//  EpisodesModel.swift
//  RickAndMorty
//
//  Created by Александра Кострова on 22.08.2023.
//

import Foundation

struct EpisodesModel: Codable {
    let results: [Episode]
}

struct Episode: Codable {
    let id: Int
    let name: String
    let airDate: String?
    let episode: String?
    let characters: [String]
    let url: String?
    let created: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case airDate = "air_date"
        case episode, characters, url, created
    }
}
