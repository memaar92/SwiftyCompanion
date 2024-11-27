//
//  HomeView.swift
//  SwiftyCompanion
//
//  Created by Marius Messerschmied on 23.11.24.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        if !viewModel.isSignedIn {
            LoginView()
        } else {
            IDView()
        }
    }
}

#Preview {
    HomeView()
}
