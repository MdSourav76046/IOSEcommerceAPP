//
//  AuthenticationEnvironmentKey.swift
//  EcomApp
//
//  Created by Md.Sourav on 14/3/25.
//

import Foundation
import SwiftUI


private struct AuthenticationEnvironmentKey: EnvironmentKey {
    static let defaultValue = AuthonticationController(httpClient: HTTPClient())
}

extension EnvironmentValues {
    var authenticationController : AuthonticationController {
        get { self[AuthenticationEnvironmentKey.self] }
        set { self[AuthenticationEnvironmentKey.self] = newValue }
    }
}


