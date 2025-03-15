//
//  ContentView.swift
//  EcomApp
//
//  Created by Md.Sourav on 8/3/25.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.authenticationController) private var authenticationControler
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
