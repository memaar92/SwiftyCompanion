//
//  FindPeersView.swift
//  SwiftyCompanion
//
//  Created by Marius Messerschmied on 29.11.24.
//

import SwiftUI

struct FindPeersView: View {
    
    @StateObject private var viewModel = FindPeersViewModel()
    @State private var navPath = NavigationPath()
    @State private var showingAlert = false
    @State private var selectedAlert: AlertItem?
    
    var body: some View {
        ZStack {
            BackgroundView()
            NavigationStack (path: $navPath) {
                HStack {
                    activeFilterButtonView(activeFilter: $viewModel.activeFilter)
                    Spacer()
                }
                .padding(.leading)
                List {
                    ForEach(viewModel.filteredPeers) { peer in
                        NavigationLink(value: peer.id) {
                            peerItemView(peer: peer)
                                .onAppear {
                                    Task {
                                        await loadMoreItems(currentPeer: peer)
                                    }
                                }
                        }
                    }
                }
                .navigationDestination(for: Int.self) { peerID in
                    PeerIDView(navPath: $navPath, userID: peerID)
                }
                .searchable(text: $viewModel.searchTerm, prompt: "Find peers")
                .autocapitalization(.none)
                .onSubmit(of: .search) {
                    DispatchQueue.main.async {
                        viewModel.searchMode = true
                        viewModel.searchTermSubmitted = viewModel.searchTerm
                    }
                    Task {
                        await loadSearchContent()
                    }
                }
            }
        }
        .alert(selectedAlert?.title ?? Text("Server Error"), isPresented: $showingAlert, presenting: selectedAlert, actions: {detail in
            if detail == AlertContext.invalidSeachTerm || detail == AlertContext.noAdditionalPeersData {
                Button("OK") {}
            }
            else if detail == AlertContext.noPeersData {
                Button("Retry") {
                    Task { await loadSearchContent() }
                }
                Button("Cancel", role: .cancel, action: {})
            } else {
                Button("OK") {
                    Task { try await AuthManager.shared.deleteTokenOnKeychain() }
                }
            }
        }, message: { detail in detail.message })
    }
    
    
    private func loadSearchContent() async {
        do {
            try await viewModel.loadMoreContent()
        } catch SearchError.invalidSearchTerm {
            selectedAlert = AlertContext.invalidSeachTerm
            showingAlert = true
        } catch NetworkError.noResponse, NetworkError.responseNotDecodable, NetworkError.unsuccessfulResponse {
            selectedAlert = AlertContext.noPeersData
            showingAlert = true
        } catch {
            selectedAlert = AlertContext.expiredAuth
            showingAlert = true
        }
    }
    
    private func loadMoreItems(currentPeer: Peer) async {
        do {
            try await viewModel.loadMoreContentIfNeeded(currentPeer: currentPeer)
        } catch NetworkError.noResponse, NetworkError.responseNotDecodable, NetworkError.unsuccessfulResponse {
            selectedAlert = AlertContext.noAdditionalPeersData
            showingAlert = true
        } catch {
            selectedAlert = AlertContext.expiredAuth
            showingAlert = true
        }
    }
    
}


struct activeFilterButtonView: View {
    @Binding var activeFilter: Bool
    
    var body: some View {
        Button {
            activeFilter.toggle()
        } label: {
            HStack {
                Image(systemName: activeFilter ? "line.3.horizontal.decrease.circle.fill" : "line.3.horizontal.decrease")
                    .frame(height: 16)
                Text("active")
                    .font(.footnote)
            }
            .padding(8)
            .background(activeFilter ? Color.HL_2 : Color.customWhite)
            .foregroundColor(activeFilter ? Color.white: Color.black)
            .cornerRadius(8)
        }
    }
}

struct peerItemView: View {
    
    var peer: Peer
    
    var body: some View {
        VStack (alignment: .leading) {
            Text(peer.login)
                .font(.headline)
            Text(peer.kind)
            Text(peer.active ? "Active" : "Inactive")
        }
        
    }
}


#Preview {
    FindPeersView()
}
