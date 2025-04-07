//
//  UploaderEnvironmentKey.swift
//  EcomApp
//
//  Created by Md.Sourav on 22/3/25.
//

import Foundation
import SwiftUI

private struct UploaderEnvironmentKey: EnvironmentKey {
    static let defaultValue = UploaderDownloader(httpClient: HTTPClient())
}

extension EnvironmentValues {
    var uploaderDownloader: UploaderDownloader {
        get{ self[UploaderEnvironmentKey.self]}
        set{ self[UploaderEnvironmentKey.self] = newValue }
    }
}


