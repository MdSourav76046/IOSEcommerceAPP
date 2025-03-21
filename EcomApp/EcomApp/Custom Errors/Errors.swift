//
//  Errors.swift
//  EcomApp
//
//  Created by Md.Sourav on 20/3/25.
//

import Foundation

enum ProductSaveError: Error {
    case missingUserId
    case invalidPrice
    case operationFailed(String)
    case missingImage
}

enum UserError: Error {
    case missingId
}
