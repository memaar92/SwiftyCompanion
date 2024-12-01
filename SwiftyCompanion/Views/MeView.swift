//
//  MeView.swift
//  SwiftyCompanion
//
//  Created by Marius Messerschmied on 01.12.24.
//

import SwiftUI

struct MeView: View {
    
    @EnvironmentObject var viewModel: UserViewModel
    
    var body: some View {
        IDView(user: viewModel.user)
    }
}

#Preview {
    MeView()
        .environmentObject(UserViewModel())
}
