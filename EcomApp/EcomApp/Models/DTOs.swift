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
        Product(id: 1, name: "Chair", description: "This is a fucking chair", price: 20, photoUrl: URL(string: "http://localhost:8080/uploads/chair.png"), userId: 19)
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
