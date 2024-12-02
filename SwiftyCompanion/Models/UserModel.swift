//
//  UserModel.swift
//  SwiftyCompanion
//
//  Created by Marius Messerschmied on 02.12.24.
//

import SwiftUI

struct Peer: Decodable, Identifiable {
    let id: Int
    let login: String
}

struct FortyTwoUser: Decodable, Identifiable {
    let id: Int
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

