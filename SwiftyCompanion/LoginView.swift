//
//  LoginView.swift
//  SwiftyCompanion
//
//  Created by Marius Messerschmied on 23.11.24.
//

import SwiftUI

struct LoginView: View {
    
    @Binding var isloggedIn: Bool
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.yellow)
                .blur(radius: 80)
                .position(x: 200, y: 400)
                .opacity(0.8)
            VStack {
                Spacer()
                Text("Swifty\nCompanion")
                    .font(.largeTitle)
                    .foregroundColor(.black)
                    .padding()
                Spacer()
                Button {
                    //add 42 API call
                    isloggedIn.toggle()
                } label: {
                    ButtonView(title: "Login with 42")
                }
                .padding()
            }
        }
    }
}

#Preview {
    LoginView(isloggedIn: .constant(false as Bool))
}
