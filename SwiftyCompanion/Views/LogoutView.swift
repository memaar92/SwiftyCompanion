//
//  LogoutView.swift
//  SwiftyCompanion
//
//  Created by Marius Messerschmied on 29.11.24.
//

import SwiftUI

struct LogoutView: View {
    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                Spacer()
                Text("It's a dangerous business, Frodo, going out your door. You step onto the road, and if you don't keep your feet, there's no knowing where you might be swept off to. Think twice before logging out.")
                    .frame(width: 200)
                Text("J.R.R. Tolkien")
                    .padding()
                Button {
                    Task {
                        try await AuthManager.shared.deleteTokenOnKeychain()
                    }
                } label: {
                    Text("Logout")
                        .foregroundStyle(.red)
                }
                Spacer()
            }
            
        }
    }
}

#Preview {
    LogoutView()
}
