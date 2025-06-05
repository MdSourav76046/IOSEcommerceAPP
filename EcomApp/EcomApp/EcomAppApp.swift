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
    @State private var cartStore = CartStore(httpClient: HTTPClient())
    
    @AppStorage("userId") private var userId: String?
    
    var body: some Scene {
        WindowGroup {
            HomeScreen()
            .environment(\.authenticationController, .development)
            .environment(productStore)
            .environment(cartStore)
            .environment(\.uploaderDownloader, UploaderDownloader(httpClient: HTTPClient()))
            .task(id: userId) {
                do {
                    if userId != nil {
                        try await cartStore.loadCart()
                    }
                }
                catch {
                    print(error.localizedDescription)
                }
            }
        }
    }
}
