//
//  AuthorizedRequest.swift
//  SwiftyCompanion
//
//  Created by Marius Messerschmied on 27.11.24.
//

import SwiftUI

class NetworkingWrapper {

    let authManager: AuthManager

    init(authManager: AuthManager) {
        self.authManager = authManager
    }

    func makeAuthorizedGetRequest<T: Decodable>(url: URL) async throws -> T {
        let request = try await createAuthorizedGetRequest(from: url)
       
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // add more error checking
        if let response = response as? HTTPURLResponse, response.statusCode == 401 {
            // usually here we would retry if we have a refresh token
            throw NetworkError.unsuccessfulResponse
        }
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.unsuccessfulResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.unsuccessfulResponse
        }
        
        
    }

    private func createAuthorizedGetRequest(from url: URL) async throws -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let accessToken = try await authManager.getToken()
        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        return request
    }
}