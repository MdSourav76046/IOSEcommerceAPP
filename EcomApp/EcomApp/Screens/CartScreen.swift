//
//  CartScreen.swift
//  EcomApp
//
//  Created by Md.Sourav on 6/6/25.
//

import SwiftUI

struct CartScreen: View {
    @Environment(CartStore.self) private var cartStore
    var body: some View {
        List {
            if let cart = cartStore.cart {
                ForEach(cart.cartItems) { cartItem in
                    Text(cartItem.product.description)
                }
            }
            else {
                ContentUnavailableView("No Items in the cart", systemImage: "cart")
            }
        }
        .task {
            do {
                try await cartStore.loadCart()
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    NavigationStack {
        CartScreen()
            .environment(CartStore(httpClient: .development))
    }
}
