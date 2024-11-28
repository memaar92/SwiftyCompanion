//
//  ButtonView.swift
//  SwiftyCompanion
//
//  Created by Marius Messerschmied on 23.11.24.
//

import SwiftUI

struct ButtonView: View {
    
    var title: String
    
    var body: some View {
        Text(title)
            .font(.title3)
            .fontWeight(.semibold)
            .frame(width: 361, height: 48)
            .background(Color.black)
            .foregroundColor(.white)
            .cornerRadius(24)
    }
}

#Preview {
    ButtonView(title: "Test title")
}
