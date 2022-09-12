//
//  HTTPClient.swift
//  MarveliOS
//
//  Created by Ricardo Castellanos Herreros on 7/9/22.
//

import Foundation

protocol HTTPClient {
    func sendRequest<T: Decodable>(endpoint: Router, responseModel: T.Type) async throws -> T
}

/// Usage let (data, response) = try await URLSession.shared.data(for: request, delegate: nil)
extension HTTPClient {
    func sendRequest<T: Decodable>(
        endpoint: Router,
        responseModel: T.Type
    ) async throws -> T {

        var request = URLComponents(string: endpoint.url)!

        if let parameters = endpoint.parameters {
            request.queryItems = parameters
        }

        guard let url = request.url else { throw ApiError.invalidURL }

        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = endpoint.method

        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest, delegate: nil)
            guard let response = response as? HTTPURLResponse else {
                throw ApiError.noResponse
            }
            switch response.statusCode {
            case 200...299:
                guard let decodedResponse = try? JSONDecoder().decode(responseModel, from: data) else {
                    throw ApiError.decode
                }
                return decodedResponse
            case 401:
                throw ApiError.unauthorised
            default:
                throw ApiError.unknown
            }
        } catch URLError.Code.notConnectedToInternet {
            throw ApiError.offline
        }
    }
}
