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
        }
        .scrollContentBackground(.hidden)
    }
}


struct ProjectItemView: View {
    
    var project: Project
    
    var body: some View {
        HStack {
            Text(project.project.name)
            Spacer()
            if project.finalMark! > 0 {
                Text("💪")
            } else {
                Text("💀")
            }
        }
        .listRowBackground(Color.BG)
    }
}

#Preview {
    ProjectView(projects: [])
}
