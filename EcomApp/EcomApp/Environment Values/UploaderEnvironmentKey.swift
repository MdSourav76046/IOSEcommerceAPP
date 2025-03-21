//
//  UploaderEnvironmentKey.swift
//  EcomApp
//
//  Created by Md.Sourav on 22/3/25.
//

import Foundation
import SwiftUI

private struct UploaderEnvironmentKey: EnvironmentKey {
    static let defaultValue = Uploader(httpClient: HTTPClient())
}

extension EnvironmentValues {
    var uploader: Uploader {
        get{ self[UploaderEnvironmentKey.self]}
        set{ self[UploaderEnvironmentKey.self] = newValue }
    }
}


