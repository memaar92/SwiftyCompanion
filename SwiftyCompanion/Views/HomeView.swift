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
                TabView {
                    IDView()
                        .tabItem {
                            Label("Me", systemImage: "widget.small")
                        }
                    FindPeersView()
                        .tabItem {
                            Label("Find Peers", systemImage: "magnifyingglass")
                        }
                    LogoutView()
                        .tabItem {
                            Label("Adventure", systemImage: "mountain.2")
                                .environment(\.symbolVariants, .none)
                        }
                }
                .accentColor(.black)
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
