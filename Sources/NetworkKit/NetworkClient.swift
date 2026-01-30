//
//  NetworkClient.swift
//  NetworkKit
//
//  Created by Mariam Joglidze on 29.01.26.
//

import Foundation

public final class NetworkClient: NetworkClientProtocol {
    
    private let session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    public func request<T: Decodable>(
        endpoint: Endpoint,
        responseType: T.Type
    ) async throws -> T {
        
        guard let url = buildURL(from: endpoint) else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        endpoint.headers?.forEach {
            request.addValue($0.value, forHTTPHeaderField: $0.key)
        }
        
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.unknown
        }
        
        guard 200..<300 ~= httpResponse.statusCode else {
            throw NetworkError.serverError(statusCode: httpResponse.statusCode)
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingFailed
        }
    }
    
    private func buildURL(from endpoint: Endpoint) -> URL? {
        var components = URLComponents(string: endpoint.baseURL)
        components?.path = endpoint.path
        components?.queryItems = endpoint.queryItems
        return components?.url
    }
}
