//
//  ParentTabView.swift
//  SwiftyCompanion
//
//  Created by Marius Messerschmied on 30.11.24.
//

import SwiftUI

struct ParentTabView: View {
    
    @StateObject var userViewModel = UserViewModel()
    
    var body: some View {
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
        .environmentObject(userViewModel)
        .task {
            do {
                try await userViewModel.getMyUser()
            } catch {
                print("Error info: \(error)")
                // add more concrete error handling based on error cases
                // replace with alert; refresh view to trigger getMyUser again?
                //print("Error getting user data")
            }
        }
    }
}

#Preview {
    ParentTabView()
}
