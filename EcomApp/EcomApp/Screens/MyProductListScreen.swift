//
//  MyProductListScreen.swift
//  EcomApp
//
//  Created by Md.Sourav on 20/3/25.
//

import SwiftUI
struct MyProductListScreen: View {
    
    @Environment(ProductStore.self) private var productStore
    @State private var isPresented : Bool = false
    @AppStorage("userId") private var userId : Int?
    @State private var message: String?
    func loadMyProducts() async {
        do {
            guard let userId = userId else{
                throw UserError.missingId
            }
            try await productStore.loadMyProducts(by: userId)
        }
        catch {
            message = error.localizedDescription
        }
    }
    
    var body: some View {
        List(productStore.myProducts) { product in
            NavigationLink {
                MyProductDetailScreen(product: product)
            } label: {
                MyProductCellView(product: product)
            }

        }
        .listStyle(.plain)
        .task {
            await loadMyProducts()
        }
        .toolbar(content: {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Add Product") {
                    isPresented = true
                }
            }
        }).sheet(isPresented: $isPresented, content: {
            NavigationStack {
                AddProductScreen()
            }
        })
        .overlay(alignment: .center){
            if let message {
                Text(message)
            }
            else if productStore.myProducts.isEmpty {
                ContentUnavailableView("No Product Found!", systemImage: "doc.text.magnifyingglass")
            }
        }
    }
}


struct MyProductCellView: View {
    let product: Product
    var body: some View {
        HStack(alignment: .top) {
            AsyncImage(url: product.photoUrl) { img in
                img.resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                    .frame(width: 100, height: 100)
            } placeholder: {
                ProgressView("Loading ...")
            }
            
            Spacer()
            
            VStack {
                Text(product.name)
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(product.price, format: .currency(code: "USD"))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
        }
    }
}

#Preview {
    NavigationStack {
        MyProductListScreen()
        
    }.environment(ProductStore(httpClient: .development))
}
