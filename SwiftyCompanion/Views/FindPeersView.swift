//
//  FindPeersView.swift
//  SwiftyCompanion
//
//  Created by Marius Messerschmied on 29.11.24.
//

import SwiftUI

struct FindPeersView: View {
    
    @StateObject private var viewModel = FindPeersViewModel()
    
    var body: some View {
        ZStack {
            BackgroundView()
            NavigationStack {
                List {
                    ForEach(viewModel.filteredPeers) { peer in
                        NavigationLink {
                            PeerDetailView(userID: peer.id)
                        } label: {
                            peerItemView(peer: peer)
                                .onAppear {
                                    Task {
                                        try await viewModel.loadMoreContentIfNeeded(currentPeer: peer)
                                    }
                                }
                        }
                    }
                }
                .searchable(text: $viewModel.searchTerm, prompt: "Find peers")
                .autocapitalization(.none)
                .onSubmit(of: .search) {
                    DispatchQueue.main.async {
                        viewModel.searchMode = true
                        viewModel.searchTermSubmitted = viewModel.searchTerm
                    }
                    Task {
                        try await viewModel.loadMoreContent()
                    }
                }
            }
        }
    }
}


struct peerItemView: View {
    
    var peer: Peer
    
    var body: some View {
        Text(peer.login)
            .font(.headline)
    }
}


#Preview {
    FindPeersView()
}
