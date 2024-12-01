//
//  DetailView.swift
//  CardExperiment
//
//  Created by Marius Messerschmied on 21.11.24.
//

import SwiftUI

struct DetailView: View {
    
    @StateObject var viewModel = DetailViewModel()
    @EnvironmentObject var userViewModel: UserViewModel
    @State private var currentSegment = "Projects"
    
    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                DismissButtonView()
                CustomSegmentedView(segments: viewModel.segmentTitles, selected: $currentSegment)
                if (currentSegment == "Projects") {
                    ProjectView(projects: userViewModel.user?.projectsUsers ?? [])
                }
                else if (currentSegment == "Skills") {
                    SkillsView(skills: userViewModel.user?.cursusUsers[1].skills ?? [])
                }
            }
        }
    }
}


#Preview {
    DetailView()
        .environmentObject(UserViewModel())
}
