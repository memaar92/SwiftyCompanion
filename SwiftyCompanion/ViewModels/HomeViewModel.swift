//
//  HomeViewModel.swift
//  SwiftyCompanion
//
//  Created by Marius Messerschmied on 27.11.24.
//

import SwiftUI


final class HomeViewModel: ObservableObject {
    
    @Published public var isSignedIn: Bool
    
    init() {
        isSignedIn = false
        Task {
            let isSignedIn = try await AuthManager.shared.checkToken()
            DispatchQueue.main.async {
                self.isSignedIn = isSignedIn
            }
        }
    }
}
