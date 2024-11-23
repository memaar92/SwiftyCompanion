//
//  SkillsView.swift
//  CardExperiment
//
//  Created by Marius Messerschmied on 23.11.24.
//

import SwiftUI

struct SkillsView: View {
    var body: some View {
        List {
            HStack {
                Text("First Skill")
                Spacer()
                Text("5.8")
            }
            .listRowBackground(Color.BG)
            HStack {
                Text("Second Skill")
                Spacer()
                Text("3.0")
            }
            .listRowBackground(Color.BG)
            HStack {
                Text("Third Skill")
                Spacer()
                Text("1.0")
            }
            .listRowBackground(Color.BG)
        }
        .scrollContentBackground(.hidden)
    }
}

#Preview {
    SkillsView()
}
