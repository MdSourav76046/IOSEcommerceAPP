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
                HStack{
                    Text("Total: ")
                        .font(.title)
                    Text(cartStore.total, format: .currency(code: "USD"))
                        .font(.title)
                        .bold()
                }
                
                Button {
                   // Action code is written here
                } label: {
                    Text("Proceed to checkout^[(\(cartStore.itemsCount) Item)](inflect: true))")
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundStyle(.white)
                        .cornerRadius(8)
                }
                .buttonStyle(.borderless)
                
                CartItemListView(cartItems: cart.cartItems)
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
