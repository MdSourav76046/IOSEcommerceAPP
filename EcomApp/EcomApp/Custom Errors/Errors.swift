//
//  Errors.swift
//  EcomApp
//
//  Created by Md.Sourav on 20/3/25.
//

import Foundation

enum ProductError: Error {
    case missingUserId
    case invalidPrice
    case operationFailed(String)
    case missingImage
    case uploadFailed(String)
    case productNotFound
}

enum UserError: Error {
    case missingId
}
