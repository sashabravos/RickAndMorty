//
//  RequestManager.swift
//  RickAndMorty
//
//  Created by Александра Кострова on 22.08.2023.
//

import Foundation

final class RequestManager {
    static let shared = RequestManager()
    private init() {}
    
    private let baseUrl = "https://rickandmortyapi.com/api"
    
    public func getCharacters(with page: Int) async throws -> CharactersModel {
        let url = URL(string: "\(baseUrl)/character/?page=\(page)")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try decodeData(CharactersModel.self, from: data)
    }
    
    private func decodeData<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}
