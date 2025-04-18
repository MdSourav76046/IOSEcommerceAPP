//  ProductStore.swift
//  EcomApp
//
//  Created by Md.Sourav on 18/3/25.

import Foundation
import Observation

@Observable
@MainActor
class ProductStore {
    
    let httpClient: HTTPClient
    private(set) var products: [Product] = []
    private(set) var myProducts: [Product] = []
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    func loadAllProducts() async throws {
        let resource = Resource(url: Constants.Urls.products, modelType: [Product].self)
        products = try await httpClient.load(resource)
    }
    
    func loadMyProducts(by userId: Int) async throws {
        let resource  =  Resource(url: Constants.Urls.myProducts(userId), modelType: [Product].self)
        myProducts = try await httpClient.load(resource)
    }
    
    func saveProduct(_ product: Product) async throws {
        let resource = Resource(url: Constants.Urls.createProduct, method: .post(product.encode()), modelType: CreateProductResponse.self)
        let response = try await httpClient.load(resource)

        if let product = response.product, response.success {
            myProducts.append(product)
        } else {
            throw ProductError.operationFailed(response.message ?? "")
        }
        
    }
    
    func deleteProduct(_ product: Product) async throws {
        
        guard let productId = product.id else {
            throw ProductError.productNotFound 
        }
        
        let resource = Resource(url: Constants.Urls.deleteProduct(productId), method: .delete, modelType: DeleteProductResponse.self)
        let response = try await httpClient.load(resource)
        
        if response.success {
            if let indexToDelete = myProducts.firstIndex(where: {$0.id == product.id}) {
                myProducts.remove(at: indexToDelete)
            }
            else {
                throw ProductError.productNotFound
            }
        }
        else {
            throw ProductError.operationFailed(response.message ?? "")
        }
        
    }
    
    func updateProduct(_ product: Product) async throws {
        guard let productId = product.id else {
            throw ProductError.productNotFound
        }
        
        let resource = Resource(url: Constants.Urls.updateProduct(productId), method: .put(product.encode()), modelType: UpdateProductResponse.self)
        
        let response = try await httpClient.load(resource)
        
        if let updatedProduct = response.product, response.success {
            if let indexToUpdate = myProducts.firstIndex(where: { $0.id == product.id }) {
                myProducts[indexToUpdate] = updatedProduct
            } else {
                throw ProductError.productNotFound
            }
        }
        else {
            throw ProductError.operationFailed(response.message ?? "")
        }
    }
}
