//
//  APIClientProtocols.swift
//  NewsAppiOS
//
//  Created by Pragati RAWAT on 12/11/23.
//

import Foundation

protocol APIServiceProtocol {    
    func request<T: Codable>(session: URLSession,
                             _ endpoint: APIEndpoint,
                             type: T.Type) async throws -> Result<T?, NetworkingError>
}
