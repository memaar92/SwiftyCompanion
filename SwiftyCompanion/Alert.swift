//
//  Alert.swift
//  SwiftyCompanion
//
//  Created by Marius Messerschmied on 26.11.24.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}

struct AlertContext {
    static let missingCode = AlertItem(
        title: Text("Authentication Failed"),
        message: Text("Could not get what we were looking for. Please try again later."),
        dismissButton: .default(Text("OK"))
    )
    static let missingToken = AlertItem(
        title: Text("Authentication Failed"),
        message: Text("Could not get what we were looking for. Please try again later."),
        dismissButton: .default(Text("OK"))
    )
    static let noResponse = AlertItem(
        title: Text("Server Error"),
        message: Text("Could not connect to 42. Please try again later."),
        dismissButton: .default(Text("OK"))
    )
    static let unsuccessfulResponse = AlertItem(
        title: Text("Authentication Failed"),
        message: Text("Could not get what we were looking for. Please try again later."),
        dismissButton: .default(Text("OK"))
    )
    static let genericError = AlertItem(
        title: Text("Authentication Failed"),
        message: Text("Something went wrong. Please try again later."),
        dismissButton: .default(Text("OK"))
    )
}
