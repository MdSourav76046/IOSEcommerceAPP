//
//  ProfileScreen.swift
//  EcomApp
//
//  Created by Md.Sourav on 17/3/25.
//

import SwiftUI

struct ProfileScreen: View {
    
    @AppStorage("userId") private var userId: String?
    var body: some View {
        Button("Signout") {
            let _ = Keychain<String>.delete("jwttoken")
            userId = nil
        }
    }
}

#Preview {
    ProfileScreen()
}
