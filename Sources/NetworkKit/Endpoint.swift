//
//  Endpoint.swift
//  NetworkKit
//
//  Created by Mariam Joglidze on 29.01.26.
//

import Foundation

public protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var queryItems: [URLQueryItem]? { get }
}

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}


public extension Endpoint {
    var headers: [String: String]? { nil }
    var queryItems: [URLQueryItem]? { nil }
}
