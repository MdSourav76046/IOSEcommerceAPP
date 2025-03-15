//
//  String+Extensions.swift
//  EcomApp
//
//  Created by Md.Sourav on 15/3/25.
//

import Foundation

extension String {
    var isEmptyOrWhitespace: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
