//
//  ProjectView.swift
//  CardExperiment
//
//  Created by Marius Messerschmied on 23.11.24.
//

import SwiftUI

struct ProjectView: View {
    var body: some View {
        List {
            HStack {
                Text("First Project")
                Spacer()
                Text("💪")
            }
            .listRowBackground(Color.BG)
            HStack {
                Text("Second Project")
                Spacer()
                Text("💪")
            }
            .listRowBackground(Color.BG)
            HStack {
                Text("Third Project")
                Spacer()
                Text("💀")
            }
            .listRowBackground(Color.BG)
        }
        .scrollContentBackground(.hidden)
    }
}

#Preview {
    ProjectView()
}
