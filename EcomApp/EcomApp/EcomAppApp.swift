//
//  EcomAppApp.swift
//  EcomApp
//
//  Created by Md.Sourav on 8/3/25.
//

import SwiftUI

@main
struct EcomAppApp: App {
    
    @State private var productStore = ProductStore(httpClient: HTTPClient())
    var body: some Scene {
        WindowGroup {
            HomeScreen()
            .environment(\.authenticationController, .development)
            .environment(productStore)
        }
    }
}
