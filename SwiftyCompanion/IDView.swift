//
//  ContentView.swift
//  SwiftyCompanion
//
//  Created by Marius Messerschmied on 23.11.24.
//

import SwiftUI

struct IDView: View {
    
    @State var isShowingDetailView = false
    
    var body: some View {
        ZStack {
            BackgroundView()
            Circle()
                .fill(Color.yellow)
                .blur(radius: 20)
                .position(x: 110, y: 520)
            VStack {
                ProfileCardView()
                    .padding(40)
                    .opacity(0.8)
                    .onTapGesture {
                        isShowingDetailView.toggle()
                    }
                Text("😎 mamesser")
                    .font(.largeTitle)
                    .padding(.bottom, 10)
                VStack (alignment: .leading) {
                    HStack {
                        Image(systemName: "star")
                        Text("level 11")
                            .font(.body)
                    }
                    .padding(4)
                    HStack {
                        Image(systemName: "dollarsign.circle")
                        Text("wallet 2711")
                            .font(.body)
                    }
                    .padding(4)
                    HStack {
                        Image(systemName: "pencil.tip.crop.circle")
                        Text("eval points 5")
                    }
                    .padding(4)
                }
               
                Spacer()
            }
            .sheet(isPresented: $isShowingDetailView) {
                DetailView()
                    .presentationDragIndicator(.visible)
            }
        }
    }
}

struct ProfileCardView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(Color.purple)
                .stroke(
                    .linearGradient(colors: [
                        .white.opacity(0.5),
                        .clear,
                        .purple.opacity(0.2),
                        .purple.opacity(0.5),
                    ], startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 15
                )
                .frame(width: 325, height: 418)
                .shadow(radius: 8)
            
            Image("profile_image")
                .resizable()
                .aspectRatio(contentMode: .fill)
        }
        .frame(width: 325, height: 418)
        .cornerRadius(24)
        .shadow(radius: 8)
    }
}

#Preview {
    IDView()
}
