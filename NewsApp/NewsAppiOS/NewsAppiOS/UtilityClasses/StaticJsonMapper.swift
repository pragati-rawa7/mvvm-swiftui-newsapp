//
//  UtilityClass.swift
//  NewsAppiOS
//
//  Created by Pragati RAWAT on 12/3/23.
//

import Foundation

struct StaticJSONMapper {
    
    static func decode<T: Decodable>(file: String, type: T.Type) throws -> T {
        
        guard !file.isEmpty,
              let path = Bundle.main.path(forResource: file, ofType: "json"),
              let data = FileManager.default.contents(atPath: path) else {
            throw NetworkingError.invalidData
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(T.self, from: data)
    }
}

