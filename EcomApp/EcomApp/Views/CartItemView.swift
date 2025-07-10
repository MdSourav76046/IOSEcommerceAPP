//
//  CartItemView.swift
//  EcomApp
//
//  Created by Md.Sourav on 10/7/25.
//

import SwiftUI

struct CartItemView: View {
    let cartItem: CartItem
    var body: some View {
        HStack(alignment: .top) {
            AsyncImage(url: cartItem.product.photoUrl) {img in
                img.resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 16.0, style: .continuous))
                    .frame(width: 100, height: 100)
            } placeholder: {
                ProgressView("Loading...")
            }
            
            Spacer()
                .frame(width: 20)
            
            VStack(alignment: .center) {
                Text(cartItem.product.name)
                    .font(.title3)
                Text(cartItem.product.price, format: .currency(code: "USD"))
            }
            .frame(height: 100)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    CartItemView(cartItem: Cart.preview.cartItems[0])
}
