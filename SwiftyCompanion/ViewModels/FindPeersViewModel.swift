//
//  FindPeersViewModel.swift
//  SwiftyCompanion
//
//  Created by Marius Messerschmied on 29.11.24.
//

import SwiftUI

class FindPeersViewModel: ObservableObject {
    
    let networkManager = NetworkManager()
    @Published var peers: [Peer] = []
    
    func getPeers() async throws {
        let url = URL(string: "https://api.intra.42.fr/v2/campus/44/users")!
        let peers = try await networkManager.makeAuthorizedGetRequest(url: url) as [Peer]
        DispatchQueue.main.async {
            self.peers = peers
        }
    }
    
}

struct Peer: Decodable {
    let id: Int
    let login: String
}
