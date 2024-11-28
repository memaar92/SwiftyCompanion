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
    //@Binding var isSignedIn: Bool
    @State private var selectedAlert: AlertItem?
    
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
                    Task {
                        do {
                            let callbackURL = try await webAuthenticationSession.authenticate(
                                using: viewModel.url42Auth,
                                callbackURLScheme: viewModel.callBackURLScheme,
                                preferredBrowserSession: .ephemeral)
                            try await viewModel.authWith42(callbackURL: callbackURL)
                            //isSignedIn.toggle()
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

#Preview {
    LoginView()
}
