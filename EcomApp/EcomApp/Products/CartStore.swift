//
//  CartStore.swift
//  EcomApp
//
//  Created by Md.Sourav on 9/5/25.
//

import Foundation
import Observation


@Observable
@MainActor
class CartStore {
    let httpClient: HTTPClient
    var cart: Cart?
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    var total: Float {
        var totalAmount: Float = 0.0
        if let cartItems = cart?.cartItems {
            for cartItem in cartItems {
                totalAmount += cartItem.product.price * Float(cartItem.quantity)
            }
        }
        return totalAmount
    }
    
    var itemsCount: Int {
        var totalItem = 0
        if let cartItems = cart?.cartItems {
            for cartItem in cartItems {
                totalItem += cartItem.quantity
            }
        }
        return totalItem
    }

    
    
    func loadCart() async throws {
        let resource = Resource(url: Constants.Urls.loadCart, modelType: CartResponse.self)
        let response = try await httpClient.load(resource)
        
        if let cart = response.cart, response.success {
            self.cart = cart
        }
        else {
            throw CartError.operationFailed(response.message ?? "")
        }
    }
    
    func addItemToCart(productId: Int, quantity: Int) async throws {
        let body  = ["productId": productId, "quantity": quantity]
        let bodyData = try JSONEncoder().encode(body)
        
        let resource = Resource(url: Constants.Urls.addCartItem, method: .post(bodyData), modelType: CartItemResponse.self)
        let response = try await httpClient.load(resource)
        
        
        if let cartItem = response.cartItem, response.success {
            // Initialize the cart if it is nill
            if cart == nil {
                guard let userId = UserDefaults.standard.userId else { throw UserError.missingId }
                cart = Cart(userId: userId)
            }
            
            // If item already in cart then update it
            if let index = cart?.cartItems.firstIndex(where: { $0.id == cartItem.id }) {
                cart?.cartItems[index] = cartItem
            }
            else {
                // it the cart is empty
                cart?.cartItems.append(cartItem)
            }
        }
        else {
            throw CartError.operationFailed(response.message ?? "")
        }
    }
}

