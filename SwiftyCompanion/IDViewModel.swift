//
//  IDViewModel.swift
//  SwiftyCompanion
//
//  Created by Marius Messerschmied on 26.11.24.
//

import SwiftUI

struct FortyTwoUser: Decodable {
    // add relevant 42 attributes
    let login: String
    let wallet: Int
    let correction_point: Int
    // how to add nested json?
    // e.g. cursus_users[level]
}
