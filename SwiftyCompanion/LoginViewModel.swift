//
//  LoginViewModel.swift
//  SwiftyCompanion
//
//  Created by Marius Messerschmied on 24.11.24.
//

import SwiftUI

class LoginViewModel: ObservableObject {
    
    let url42Auth: URL
    let callBackURLScheme: String = "swiftyapp"
    
    init() {
        url42Auth = buildEndpoint()
    }
    
    func authWith42(callbackURL: URL) async throws {
        let queryItems = URLComponents(string: callbackURL.absoluteString)?.queryItems
        guard let code = queryItems?.filter({ $0.name == "code" }).first?.value else {
            throw NetworkError.missingCode
        }
        print("Code: \(code)")
        // may remove guard; depening on what is done with token
        guard let token = try await getToken(code: code) else {
            throw NetworkError.missingToken
        }
        print ("Token: \(token)")
    }
    
    func getToken(code: String) async throws -> String? {
        let url = URL(string: "https://api.intra.42.fr/oauth/token")!
        let postData = PostData(code: code, client_id: ProcessInfo.processInfo.environment["clientID"]!, client_secret: ProcessInfo.processInfo.environment["clientSecret"]!, grant_type: "authorization_code", redirect_uri: "swiftyapp://oauth-callback")
        // may also run in a do {} statement?
        let jsonData = try JSONEncoder().encode(postData)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
            throw NetworkError.noResponse
        }
        guard (200...299).contains(statusCode) else {
            throw NetworkError.unsuccessfulResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let token = try decoder.decode(Token.self, from: data)
            return token.accessToken
        } catch {
            throw NetworkError.missingToken
        }
    }
    
}

func buildEndpoint() -> URL {
    let clientID = ProcessInfo.processInfo.environment["clientID"] ?? ""
    let url = "https://api.intra.42.fr/oauth/authorize?client_id=" + clientID + "&redirect_uri=swiftyapp%3A%2F%2Foauth-callback&response_type=code"
    return URL(string: url)!
}


struct Token: Decodable {
    let accessToken: String
}

struct PostData: Encodable {
    let code: String
    let client_id: String
    let client_secret: String
    let grant_type: String
    let redirect_uri: String
}

enum NetworkError: Error {
    case missingCode
    case missingToken
    case noResponse
    case unsuccessfulResponse
}


