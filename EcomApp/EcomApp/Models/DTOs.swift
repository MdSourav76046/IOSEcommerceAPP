//
//  DTOs.swift
//  EcomApp
//
//  Created by Md.Sourav on 15/3/25.
//

import Foundation

struct RegisterResponse : Codable {
    let messege: String?
    let success: Bool
}

struct ErrorResponse: Codable {
    let message: String
}

