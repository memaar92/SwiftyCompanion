//
//  PeerView.swift
//  SwiftyCompanion
//
//  Created by Marius Messerschmied on 01.12.24.
//

import SwiftUI

struct PeerView: View {
    
    @StateObject private var viewModel = UserViewModel()
    let userID: Int
    
    var body: some View {
        VStack {
            IDView(user: viewModel.user)
                .padding(.top, -20)
        }
        .onAppear {
            Task {
                do {
                    try await viewModel.getSelectedUser(id: userID)
                } catch {
                    print("error: \(error)")
                }
            }
        }
    }
    
    
}

#Preview {
    PeerView(userID: 42)
}