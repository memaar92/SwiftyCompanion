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
        isSignedIn = true
        Task {
            do {
                try await AuthManager().getToken()
            } catch {
                isSignedIn = false
            }
        }
    }
}
