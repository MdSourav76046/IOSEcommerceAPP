//
//  CartItemListView.swift
//  EcomApp
//
//  Created by Md.Sourav on 9/7/25.
//

import SwiftUI

struct CartItemListView: View {
    let cartItems: [CartItem]
    var body: some View {
        ForEach(cartItems) { cartItem in
            CartItemView(cartItem: cartItem)
        }.listStyle(.plain)
    }
}

#Preview {
    CartItemListView(cartItems: Cart.preview.cartItems)
}
