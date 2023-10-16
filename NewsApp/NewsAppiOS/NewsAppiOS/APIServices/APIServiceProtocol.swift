//
//  APIClientProtocols.swift
//  NewsAppiOS
//
//  Created by Pragati RAWAT on 12/11/23.
//

import Foundation

protocol APIServiceProtocol {
   // func executeAPI<T: Decodable>(endPoint: APIEndpoint) async throws -> Result<T?, FetchError<Any>>
    
    func request<T: Codable>(session: URLSession,
                             _ endpoint: APIEndpoint,
                             type: T.Type) async throws -> Result<T?, NetworkingError>
}
