//
//  CharactersModel.swift
//  RickAndMorty
//
//  Created by Александра Кострова on 22.08.2023.
//

import Foundation

struct CharactersModel: Codable {
    let results: [Character]
    let info: Info
}

struct Info: Codable {
    let count: Int
    let pages: Int
    let next: URL?
    let prev: URL?
}

struct Character: Codable {
    let id: Int
    let name: String
    let status: String?
    let species: String?
    let type: String?
    let gender: String?
    let origin, location: Location?
    let image: String?
    let episode: [String]?
    let url: String?
    let created: String?
}

struct Location: Codable {
    let name: String?
    let url: String?
}
