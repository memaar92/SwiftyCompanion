//
//  IDViewModel.swift
//  SwiftyCompanion
//
//  Created by Marius Messerschmied on 26.11.24.
//

import SwiftUI

func getMyUser() async throws -> FortyTwoUser {
    
    let networkUtil = NetworkingWrapper(authManager: AuthManager()) // is this the correct usage?
    let url = URL(string: "https://api.intra.42.fr/v2/me")!
    
    let user = try await networkUtil.makeAuthorizedGetRequest(url: url) as FortyTwoUser
    return user
}


struct FortyTwoUser: Decodable {
    let image: ImageLink
    let login: String
    let wallet: Int
    let correctionPoint: Int
    let cursusUsers: [Cursus]
    let projectsUsers: [Project]
}

struct ImageLink: Decodable {
    let link: String
}

struct Cursus: Decodable {
    let level: Double
    let skills: [Skill]
}

struct Skill: Decodable, Identifiable {
    let id: Int
    let name: String
    let level: Double
}

struct Project: Decodable, Identifiable {
    let id: Int
    let finalMark: Int?
    let status: String
    let project: ProjectName
}

struct ProjectName: Decodable {
    let name: String
}
