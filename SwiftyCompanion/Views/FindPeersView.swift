//
//  FindPeersView.swift
//  SwiftyCompanion
//
//  Created by Marius Messerschmied on 29.11.24.
//

import SwiftUI

struct FindPeersView: View {
    
    @StateObject private var viewModel = FindPeersViewModel()
    @State private var searchTerm: String = ""
    
    var filteredPeers: [Peer] {
        guard !searchTerm.isEmpty else { return viewModel.peers }
        return viewModel.peers.filter { $0.login.localizedCaseInsensitiveContains(searchTerm) }
    }
    
    var body: some View {
        ZStack {
            BackgroundView()
            NavigationStack {
                List(filteredPeers, id: \.id) { peer in
                    Text(peer.login)
                        .font(.headline)
                }
            }
            .task {
                do {
                    try await viewModel.getPeers()
                } catch {
                    // add catches
                }
            }
            .searchable(text: $searchTerm, prompt: "Find peers")
        }
    }
}

#Preview {
    FindPeersView()
}
