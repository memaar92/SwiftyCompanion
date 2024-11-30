//
//  ContentView.swift
//  SwiftyCompanion
//
//  Created by Marius Messerschmied on 23.11.24.
//

import SwiftUI

struct IDView: View {
    
    @EnvironmentObject var viewModel: UserViewModel
    @State var isShowingDetailView = false
    
    var body: some View {
        ZStack {
            BackgroundView()
            Circle()
                .fill(Color .HL_1)
                .position(x: 50, y: 250)
                .frame(width: 300, height: 300)
            VStack {
                ProfileCardView(user: viewModel.user)
                    .padding(40)
                    .opacity(0.8)
                    .onTapGesture {
                        isShowingDetailView.toggle()
                    }
                Text("😎 \(viewModel.user?.login ?? "")")
                    .padding(8)
                    .font(.custom("ChivoMono-Light", size: 30))
                    .background(Color.customWhite)
                VStack (alignment: .leading) {
                    DetailItemView(detail: "level",
                                    value: Text("\(viewModel.user?.cursusUsers[1].level ?? 0, specifier: "%.2f")"))
                    DetailItemView(detail: "wallet",
                                    value: Text("\(viewModel.user?.wallet ?? 0)$"))
                    DetailItemView(detail: "eval points",
                                    value: Text("\(viewModel.user?.correctionPoint ?? 0)"))
                }
                .frame(maxWidth: 235)
                Spacer()
            }
            .sheet(isPresented: $isShowingDetailView) {
                DetailView(user: viewModel.user)
                    .presentationDragIndicator(.visible)
            }
        }
    }
}


struct DetailItemView: View {
    
    let detail: String
    let value: Text
    
    var body: some View {
        HStack {
            Text(detail)
                .multilineTextAlignment(.leading)
            Spacer()
            value
                .font(.body)
                .multilineTextAlignment(.trailing)
        }
        .padding(4)
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
        .environmentObject(UserViewModel())
}
