//
//  HomeView.swift
//  SwiftyCompanion
//
//  Created by Marius Messerschmied on 23.11.24.
//

import SwiftUI

struct HomeView: View {
    
    @State var isLoggedIn: Bool = false
    
    var body: some View {
        if !isLoggedIn {
            LoginView(isloggedIn: $isLoggedIn)
        } else {
            IDView()
        }
    }
}

#Preview {
    HomeView()
}
