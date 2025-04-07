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
        Product(id: 1, name: "Chair", description: "Experience the perfect balance of style and comfort with our Elegant Comfort Wooden Chair. Crafted from high-quality mahogany wood and designed with a minimalist modern aesthetic, this chair adds timeless charm to any living space, dining room, or office setting. The ergonomically curved backrest ensures excellent support, while the smooth, polished finish enhances both durability and appearance.", price: 20, photoUrl: URL(string: "http://localhost:8080/api/uploads/image-1742761150688.png"), userId: 19)
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
