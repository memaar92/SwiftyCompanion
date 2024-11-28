//
//  HomeViewModel.swift
//  SwiftyCompanion
//
//  Created by Marius Messerschmied on 27.11.24.
//

import SwiftUI


final class HomeViewModel: ObservableObject {
    
    public var isSignedIn: Bool
    
    init() {
        isSignedIn = false
        Task {
            isSignedIn = try await AuthManager().checkToken()
        }
    }
}
