//
//  AuthonticationController.swift
//  EcomApp
//
//  Created by Md.Sourav on 14/3/25.
//

import Foundation

struct AuthonticationController {
    let httpClient: HTTPClient
    
    func register(username: String, password: String) async throws -> RegisterResponse {
        let body = ["username" : username, "password" : password]
        
        let bodyData = try JSONEncoder().encode(body)
        let resource = Resource(url: Constants.Urls.register, method: .post(bodyData), modelType: RegisterResponse.self)
        
        let response = try await httpClient.load(resource)
        
        return response
    }
}


extension AuthonticationController {
    static var development: AuthonticationController {
        AuthonticationController(httpClient: HTTPClient())
    }
}
