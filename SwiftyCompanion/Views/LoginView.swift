//
//  LoginView.swift
//  SwiftyCompanion
//
//  Created by Marius Messerschmied on 23.11.24.
//

import SwiftUI
import AuthenticationServices

struct LoginView: View {
    
    @Environment(\.webAuthenticationSession) private var webAuthenticationSession
    @ObservedObject private var viewModel = LoginViewModel()
    @State private var selectedAlert: AlertItem?
    
    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                Spacer()
                TitleImageView()
                Spacer()
                Button {
                    Task {
                        do {
                            let callbackURL = try await webAuthenticationSession.authenticate(
                                using: viewModel.url42Auth,
                                callbackURLScheme: viewModel.callBackURLScheme,
                                preferredBrowserSession: .ephemeral)
                            try await viewModel.authWith42(callbackURL: callbackURL)
                        } catch AuthError.missingAuthCode, AuthError.missingAccessToken, NetworkError.unsuccessfulResponse {
                            selectedAlert = AlertContext.missingAuth
                        } catch NetworkError.noResponse {
                            selectedAlert = AlertContext.noResponse
                        } catch {
                            selectedAlert = AlertContext.genericError
                        }
                        // add catch statement for when user cancels request
                    }
                } label: {
                    ButtonView(title: "Login with 42")
                }
                .padding()
            }
        }
        .alert(item: $selectedAlert) { alert in
            Alert(title: alert.title, message: alert.message, dismissButton: alert.dismissButton)
        }
    }
}


struct TitleImageView: View {
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("Swifty\nCompanion")
                .font(.custom("ChivoMono-Light", size: 30))
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
                .padding(.leading)
            HStack () {
                Rectangle()
                    .fill(Color.customWhite)
                    .frame(width: 200, height: 150)
                Rectangle()
                    .fill(Color.HL_1)
                    .frame(width: 100, height: 150)
            }
            .padding(.bottom)
            Rectangle()
                .fill(Color.HL_2)
                .frame(width: 150, height: 5)
                .padding(.top)
                .padding(.leading)
            Rectangle()
                .fill(Color.HL_2)
                .frame(width: 120, height: 5)
                .padding()
            Rectangle()
                .fill(Color.HL_2)
                .frame(width: 120, height: 5)
                .padding(.leading)
                .padding(.bottom)
            Rectangle()
                .fill(Color.PB)
                .frame(width: 270, height: 5)
                .padding(.leading)
            
        }
        .padding()
        Circle()
            .fill(Color.HL_2)
            .frame(width: 20, height: 20)
    }
}

#Preview {
    LoginView()
}
