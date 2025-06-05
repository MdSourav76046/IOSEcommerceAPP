//
//  Constants.swift
//  EcomApp
//
//  Created by Md.Sourav on 15/3/25.
//

import Foundation

struct Constants {
    struct Urls {
        static let register: URL = URL(string: "http://localhost:8080/api/auth/register")!
        static let login: URL = URL(string: "http://localhost:8080/api/auth/login")!
        static let products: URL = URL(string: "http://localhost:8080/api/products")!
        static let createProduct: URL = URL(string: "http://localhost:8080/api/products")!
        static let myProducts: URL = URL(string: "http://localhost:8080/api/products")!
        static let addCartItem: URL = URL(string: "http://localhost:8080/api/cart/items")!
        static let loadCart: URL = URL(string: "http://localhost:8080/api/cart")!
        
        static func myProducts(_ userId: Int) -> URL  {
            return URL(string: "http://localhost:8080/api/products/user/\(userId)")!
        }
        
        static let uploadProductImage: URL = URL(string: "http://localhost:8080/api/products/upload")!
        
        static func deleteProduct(_ userId: Int) -> URL  {
            return URL(string: "http://localhost:8080/api/products/\(userId)")!
        }
        
        static func updateProduct(_ userId: Int) -> URL  {
            return URL(string: "http://localhost:8080/api/products/\(userId)")!
        }
        
    }
}
