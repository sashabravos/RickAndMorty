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
    
    enum DataType: String {
        case character, location, episode
    }
    
    /// Use with any NetworkModel, id could be character or something else ID
    public func getInfo<T: Decodable>(dataType: DataType,
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
