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
    let httpCLient: HTTPClient
    var cart: Cart?
    
    init(httpCLient: HTTPClient) {
        self.httpCLient = httpCLient
    }
    
    func addItemToCart(productId: Int, quantity: Int) async throws {
        let body  = ["productId": productId, "quantity": quantity]
        let bodyData = try JSONEncoder().encode(body)
        
        let resource = Resource(url: Constants.Urls.addCartItem, method: .post(bodyData), modelType: CartItemResponse.self)
        let response = try await httpCLient.load(resource)
        
        
        if let cartItem = response.cartItem, response.success {
            // Initialize the cart if it is nill
            if cart == nil {
                guard let userId = UserDefaults.standard.userId else { throw UserError.missingId }
            }
        }
        
        
    }
}

