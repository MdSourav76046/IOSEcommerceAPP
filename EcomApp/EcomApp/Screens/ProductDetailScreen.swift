//
//  ProductDetailScreen.swift
//  EcomApp
//
//  Created by Md.Sourav on 10/5/25.
//

import SwiftUI

struct ProductDetailScreen: View {
    let product: Product
    @Environment(CartStore.self) private var cartStore
    @State private var quantity = 0
    var body: some View {
        ScrollView {
            AsyncImage(url: product.photoUrl) { img in
                img.resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
                    .scaledToFit()
            } placeholder: {
                ProgressView("Loading...")
            }
            
            Text(product.name)
                .font(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView {
                Text(product.description)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.top], 3)
            }.frame(maxHeight: 160)
                
            
            Text(product.price, format: .currency(code: "USD"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title)
                .bold()
                .padding([.top], 2)
            
            Stepper(value: $quantity) {
                Text("Quantity \(quantity)")
            }
            .padding([.bottom], 2)
            
            Button {
                Task {
                    do {
                        try await cartStore.addItemToCart(productId: product.id!, quantity: quantity)
                    }
                    catch {
                        print(error)
                    }
                }
            } label: {
                Text("Add to cart")
                    .frame(maxWidth: .infinity)
                    .frame(height: 44)
                    .foregroundStyle(.white)
                    .background(.orange)
                    .clipShape(RoundedRectangle(cornerRadius:16.0, style: .continuous))
            }
        }
        .padding()
    }
}

#Preview {
    NavigationStack{
        ProductDetailScreen(product: Product.preview)
    }
    .environment(CartStore(httpCLient: .development))
}
