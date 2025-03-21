//
//  JSTTokenValidator.swift
//  EcomApp
//
//  Created by Md.Sourav on 17/3/25.
//

import Foundation
import JWTDecode


struct JWTTokenValidator {
    
    static func validate(token: String?) -> Bool {
        guard let token = token else { return false }
        
        do {
            let jwt = try decode(jwt: token)
            
            if let expirationData = jwt.expiresAt {
                let currentDate = Date()
                
                if(currentDate >= expirationData) {
                    return false
                }
                else {
                    return true
                }
            }
            else {
                return false
            }
        } catch {
            return false;
        }
    }
}
