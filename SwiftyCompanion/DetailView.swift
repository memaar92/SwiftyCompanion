//
//  DetailView.swift
//  CardExperiment
//
//  Created by Marius Messerschmied on 21.11.24.
//

import SwiftUI

struct DetailView: View {
    
    @StateObject var viewModel = DetailViewModel()
    @State private var currentSegment = "Projects"
    var user: FortyTwoUser?
    
    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                DismissButtonView()
                CustomSegmentedView(segments: viewModel.segmentTitles, selected: $currentSegment)
                if (currentSegment == "Projects") {
                    ProjectView(projects: user?.projectsUsers ?? [])
                }
                else if (currentSegment == "Skills") {
                    SkillsView(skills: user?.cursusUsers[1].skills ?? [])
                }
            }
        }
    }
}


#Preview {
    DetailView()
}
