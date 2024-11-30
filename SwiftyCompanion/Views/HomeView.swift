//
//  HomeView.swift
//  SwiftyCompanion
//
//  Created by Marius Messerschmied on 23.11.24.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var authManager = AuthManager.shared
    
    var body: some View {
        VStack {
            if !authManager.isLoggedIn {
                LoginView()
            } else {
                ParentTabView()
            }
        }
        .onAppear {
            Task {
                try await authManager.checkToken()
            }
        }
        
        
    }
    
}

#Preview {
    HomeView()
}
