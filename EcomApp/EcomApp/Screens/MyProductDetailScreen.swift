//
//  MyProductDetailScreen.swift
//  EcomApp
//
//  Created by Md.Sourav on 4/4/25.
//

import SwiftUI

struct MyProductDetailScreen: View {
    let product: Product
    @Environment(ProductStore.self) private var productStore
    @Environment(\.dismiss) private var dismiss
    
    
    private func deleteProduct() async {
        do {
            try await productStore.deleteProduct(product)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    var body: some View {
        ScrollView(showsIndicators: true) {
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
            
            Text(product.description)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.top], 5)
            
            Text(product.price, format: .currency(code: "USD"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.title)
                .bold()
                .padding([.top], 2)
            
            Button(role: .destructive) {
                Task{
                    await deleteProduct()
                    dismiss()
                }
            } label: {
                Text("Delete")
                    .frame(maxWidth: .infinity)
                    .frame(height: 44)
                    .cornerRadius(25)
            }
            .buttonStyle(.borderedProminent)

                
            
        }
        .padding()
    }
}

#Preview {
    NavigationStack {
        MyProductDetailScreen(product: Product.preview)
    }
    .environment(ProductStore(httpClient: .development))
}
