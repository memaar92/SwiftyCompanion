//
//  ProjectView.swift
//  CardExperiment
//
//  Created by Marius Messerschmied on 23.11.24.
//

import SwiftUI

struct ProjectView: View {
    
    var projects: [Project]
    
    var body: some View {
        List(projects) { project in
            ProjectItemView(project: project)
                .padding(-15)
        }
        .scrollContentBackground(.hidden)
        .listRowSpacing(4)
    }
}


struct ProjectItemView: View {
    
    var project: Project
    
    var body: some View {
        HStack {
            HStack {
                Text(project.project.name)
                Spacer()
            }
            .frame(width: 275, height: 40)
            .padding(.leading, 10)
            .background(Color.customWhite)
            Spacer()
            HStack {
                if project.finalMark == nil {
                    Text("🏃‍♂️")
                } else {
                    if project.finalMark! > 0 {
                        Text("💪")
                    } else {
                        Text("💀")
                    }
                }
            }
            .frame(width: 60, height: 40)
            .background(Color.customWhite)
        }
        .listRowBackground(Color.BG)
        .listRowSeparator(.hidden)
    }
}

#Preview {
    ProjectView(projects: [])
}
