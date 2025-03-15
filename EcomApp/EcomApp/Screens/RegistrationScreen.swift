//
//  RegistrationScreen.swift
//  EcomApp
//
//  Created by Md.Sourav on 15/3/25.
//

import SwiftUI

struct RegistrationScreen: View {
    
    @Environment(\.authenticationController) private var authenticationController
    
    @Environment(\.dismiss) private var dismiss
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var messege: String = ""
    
    private var isFormValid: Bool {
        !username.isEmptyOrWhitespace && !password.isEmptyOrWhitespace
    }
    
    private func register() async {
        do{
            let response = try await authenticationController.register(username: username, password: password)
            
            if response.success {
                dismiss()
            }
            else {
                messege = response.messege ?? ""
            }
        } catch {
            messege = error.localizedDescription
        }
        
        
        password = ""
        username = ""
    }
    var body: some View {
        Form {
            TextField("User Name", text: $username)
                .textInputAutocapitalization(.never)
            TextField("Password", text: $password)
            Button("Register") {
                Task {
                    await register()
                }
            }.disabled(!isFormValid)
            Text(messege)
        }.navigationTitle("Rsgister")
    }
}

#Preview {
    NavigationStack {
        RegistrationScreen()
            .environment(\.authenticationController, .development)
    }
}
