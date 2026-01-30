//
//  NetworkError.swift
//  NetworkKit
//
//  Created by Mariam Joglidze on 29.01.26.
//

import Foundation

public enum NetworkError: Error {
    case invalidURL
    case serverError(statusCode: Int)
    case decodingFailed
    case noData
    case unknown
}
