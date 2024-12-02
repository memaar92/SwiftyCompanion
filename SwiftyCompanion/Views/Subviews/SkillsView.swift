//
//  SkillsView.swift
//  CardExperiment
//
//  Created by Marius Messerschmied on 23.11.24.
//

import SwiftUI

struct SkillsView: View {
    
    var skills: [Skill]
    
    var body: some View {
        List(skills) { skill in
            SkillItemView(skill: skill)
        }
        .scrollContentBackground(.hidden)
    }
}


struct SkillItemView: View {
    
    var skill: Skill
    
    var body: some View {
        HStack {
            Text(skill.name)
            Spacer()
            Text("\(skill.level, specifier: "%.2f")")
        }
        .listRowBackground(Color.BG)
    }
}


#Preview {
    SkillsView(skills: [])
}
