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
            throw AuthError.missingAuthCode
        }
        try await createToken(code: code)
    }
    
    
    func createToken(code: String) async throws {
        let url = URL(string: "https://api.intra.42.fr/oauth/token")!
        let requestBodyData = RequestBodyData(code: code,
                                client_id: ProcessInfo.processInfo.environment["clientID"]!,
                                client_secret: ProcessInfo.processInfo.environment["clientSecret"]!,
                                grant_type: "authorization_code",
                                redirect_uri: "swiftyapp://oauth-callback")
        
        // may also run in a do {} statement?
        let jsonData = try JSONEncoder().encode(requestBodyData)
        
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
            try await storeTokenOnKeychain(token: token)
        } catch AuthError.tokenAlreadyStored {
            print("Token already stored")
        } catch {
            throw AuthError.missingAccessToken
        }
    }
    
    
    func storeTokenOnKeychain(token: Token) async throws {
        let accessToken = token.accessToken.data(using: .utf8)!
        let tag = "swiftyapp-token"
        let expirationDate = String(TimeInterval(token.createdAt + token.expiresIn)).data(using: .utf8)!
        let addquery: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                       kSecAttrAccount as String: tag,
                                       kSecAttrGeneric as String: expirationDate,
                                       kSecValueData as String: accessToken]
        
        let status = SecItemAdd(addquery as CFDictionary, nil)
        
        guard status != errSecDuplicateItem else {
            throw AuthError.tokenAlreadyStored
        }
        
        guard status == errSecSuccess else {
            throw AuthError.failToStoreToken
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
    let tokenType: String // may remove
    let expiresIn: Double
    let scope: String // may remove
    let createdAt: Double
}

struct RequestBodyData: Encodable {
    let code: String
    let client_id: String
    let client_secret: String
    let grant_type: String
    let redirect_uri: String
}




