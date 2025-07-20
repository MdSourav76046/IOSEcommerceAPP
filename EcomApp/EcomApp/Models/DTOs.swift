//
//  DTOs.swift
//  EcomApp
//
//  Created by Md.Sourav on 15/3/25.
//

import Foundation

struct RegisterResponse : Codable {
    let message: String?
    let success: Bool
}

struct ErrorResponse: Codable {
    let message: String
}

struct UploadDataResponse: Codable {
    let message: String?
    let success: Bool
    let downloadUrl: URL?
}

struct Product: Codable, Identifiable {
    var id: Int?
    let name: String
    let description: String
    let price: Float
    let photoUrl: URL?
    let userId: Int
    
    private enum CodingKeys: String, CodingKey {
        case id, name, description, price
        case photoUrl = "photo_url"
        case userId = "user_id"
    }
}

extension Product {
    static var preview : Product {
        Product(id: 71, name: "Chair", description: "Experience the perfect balance of style and comfort with our Elegant Comfort Wooden Chair. Crafted from high-quality mahogany wood and designed with a minimalist modern aesthetic, this chair adds timeless charm to any living space, dining room, or office setting. The ergonomically curved backrest ensures excellent support, while the smooth, polished finish enhances both durability and appearance.", price: 20, photoUrl: URL(string: "http://localhost:8080/api/uploads/image-1744403104753.png"), userId: 21)
    }
    
    
    func encode() -> Data? {
        try? JSONEncoder().encode(self)
    }
}

struct LoginResponse : Codable {
    let message: String?
    let token: String?
    let success: Bool
    let userId: Int?
    let username : String?
}

struct CreateProductResponse: Codable {
    let success: Bool
    let product: Product?
    let message: String?
}
 
struct DeleteProductResponse: Codable {
    let success: Bool
    let message: String?
}

struct UpdateProductResponse: Codable {
    let success: Bool
    let message: String
    let product: Product?
}

struct Cart: Codable {
    var id: Int?
    let userId: Int
    var cartItems : [CartItem] = []
    
    private enum CodingKeys: String, CodingKey {
        case id, cartItems
        case userId = "user_id"
    }
}

struct CartItem: Codable, Identifiable {
    let id: Int?
    let product: Product
    var quantity: Int = 1
}

struct CartItemResponse: Codable, @unchecked Sendable {
    let message: String?
    let success: Bool
    let cartItem: CartItem?
}

struct CartResponse: Codable {
    let success : Bool
    let message: String?
    let cart: Cart?
}

struct DeleteCartItemResponse: Codable {
    let message: String?
    let success: Bool
}


extension Cart {
    static var preview: Cart {
        return Cart(
            id: 2,
            userId: 21,
            cartItems: [
                CartItem(
                    id: 6,
                    product: Product(
                        id: 73,
                        name: "Coffee",
                        description: "This is a great coffee",
                        price: 10.50,
                        photoUrl: URL(string: "https://picsum.photos/200/300"),
                        userId: 101
                    ),
                    quantity: 2
                ),
                CartItem(
                    id: 2,
                    product: Product(
                        id: 74,
                        name: "Juice",
                        description: "This is a great Juice",
                        price: 5.50,
                        photoUrl: URL(string: "https://picsum.photos/200/300"),
                        userId: 101
                    ),
                    quantity: 3
                ),
                CartItem(
                    id: 1,
                    product: Product(
                        id: 203,
                        name: "Coca Cola",
                        description: "This is a great drink",
                        price: 20.00,
                        photoUrl: URL(string: "https://picsum.photos/200/300"),
                        userId: 101
                    ),
                    quantity: 1
                )
            ]
        )
    }
}
