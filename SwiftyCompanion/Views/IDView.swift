//
//  ContentView.swift
//  SwiftyCompanion
//
//  Created by Marius Messerschmied on 23.11.24.
//

import SwiftUI

struct IDView: View {
    
    @ObservedObject private var viewModel = IDViewModel()
    @State var isShowingDetailView = false
    
    var body: some View {
        ZStack {
            BackgroundView()
            Circle()
                .fill(Color.yellow)
                .blur(radius: 80)
                .position(x: 110, y: 520)
                .opacity(0.8)
            VStack {
                ProfileCardView(user: viewModel.user)
                    .padding(40)
                    .opacity(0.8)
                    .onTapGesture {
                        isShowingDetailView.toggle()
                    }
                Text("😎 \(viewModel.user?.login ?? "unknown")")
                    .font(.largeTitle)
                    .padding(.bottom, 10)
                VStack (alignment: .leading) {
                    HStack {
                        Image(systemName: "star")
                        Text("level \(viewModel.user?.cursusUsers[1].level ?? 0)")
                            .font(.body)
                    }
                    .padding(4)
                    HStack {
                        Image(systemName: "dollarsign.circle")
                        Text("wallet \(viewModel.user?.wallet ?? 0)")
                            .font(.body)
                    }
                    .padding(4)
                    HStack {
                        Image(systemName: "pencil.tip.crop.circle")
                        Text("eval points \(viewModel.user?.correctionPoint ?? 0)")
                    }
                    .padding(4)
                    Button {
                        Task {
                            try await AuthManager().deleteTokenOnKeychain()
                        }
                    } label: {
                        ButtonView(title: "Logout")
                    }
                }
               
                Spacer()
            }
            .task {
                do {
                   // user = try await viewModel.getMyUser()
                    try await viewModel.getMyUser()
                } catch {
                    // add more concrete error handling based on error cases
                    // send to login page? replace with alert? refresh view to trigger getMyUser again?
                    print("Error getting user data")
                }
            }
            .sheet(isPresented: $isShowingDetailView) {
                DetailView(user: viewModel.user)
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