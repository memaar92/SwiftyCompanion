//
//  HomeView.swift
//  SwiftyCompanion
//
//  Created by Marius Messerschmied on 23.11.24.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()
    @StateObject private var authManager = AuthManager.shared
    
    var body: some View {
        if !authManager.isLoggedIn {
            LoginView()
        } else {
            IDView()
        }
    }
    
}

#Preview {
    HomeView()
}
