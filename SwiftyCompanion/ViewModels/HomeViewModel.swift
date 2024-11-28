//
//  HomeViewModel.swift
//  SwiftyCompanion
//
//  Created by Marius Messerschmied on 27.11.24.
//

import SwiftUI


final class HomeViewModel: ObservableObject {
    
    //@Published public var isSignedIn: Bool
    
    init() {
        //isSignedIn = false
        Task {
            try await AuthManager.shared.checkToken()
        }
    }
}
