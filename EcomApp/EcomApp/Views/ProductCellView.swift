//
//  ProductCellView.swift
//  EcomApp
//
//  Created by Md.Sourav on 19/3/25.
//

import SwiftUI

struct ProductCellView: View {
    let product: Product
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10.0) {
            AsyncImage(url: product.photoUrl) { img in
                img.resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
            }placeholder: {
                ProgressView("Loading ...")
            }
            
            Text(product.name)
                .font(.title)
            
            Text(product.price, format: .currency(code: "USD"))
                .font(.title2)
        }.padding()
    }
}

#Preview {
    ProductCellView(product: Product.preview)
}
