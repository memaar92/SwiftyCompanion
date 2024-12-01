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
                        Text(peer.login)
                            .font(.headline)
                            .onAppear {
                                Task {
                                    try await viewModel.loadMoreContentIfNeeded(currentPeer: peer)
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


#Preview {
    FindPeersView()
}
