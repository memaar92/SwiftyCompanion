//
//  ContentView.swift
//  SwiftyCompanion
//
//  Created by Marius Messerschmied on 23.11.24.
//

import SwiftUI

struct IDView: View {
    
    @State var isShowingDetailView = false
    @State private var user: FortyTwoUser?
    
    var body: some View {
        ZStack {
            BackgroundView()
            Circle()
                .fill(Color.yellow)
                .blur(radius: 80)
                .position(x: 110, y: 520)
                .opacity(0.8)
            VStack {
                ProfileCardView(user: user)
                    .padding(40)
                    .opacity(0.8)
                    .onTapGesture {
                        isShowingDetailView.toggle()
                    }
                Text("😎 \(user?.login ?? "unknown")")
                    .font(.largeTitle)
                    .padding(.bottom, 10)
                VStack (alignment: .leading) {
                    HStack {
                        Image(systemName: "star")
                        Text("level \(user?.cursusUsers[1].level ?? 0)")
                            .font(.body)
                    }
                    .padding(4)
                    HStack {
                        Image(systemName: "dollarsign.circle")
                        Text("wallet \(user?.wallet ?? 0)")
                            .font(.body)
                    }
                    .padding(4)
                    HStack {
                        Image(systemName: "pencil.tip.crop.circle")
                        Text("eval points \(user?.correctionPoint ?? 0)")
                    }
                    .padding(4)
                }
               
                Spacer()
            }
            .task {
                do {
                    user = try await getMyUser()
                } catch {
                    // replace with alert? refresh page? to trigger getMyUser again?
                    print("Error getting user data")
                }
            }
            .sheet(isPresented: $isShowingDetailView) {
                DetailView(user: user)
                    .presentationDragIndicator(.visible)
            }
        }
    }
}

struct ProfileCardView: View {
    
    var user: FortyTwoUser?
    
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
            
            AsyncImage(url: URL(string: user?.image.link ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Rectangle()
            }
        }
        .frame(width: 325, height: 418)
        .cornerRadius(24)
        .shadow(radius: 8)
    }
}

#Preview {
    IDView()
}
