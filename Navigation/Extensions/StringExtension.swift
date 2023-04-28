//
//  StringExtension.swift
//  Navigation
//
//  Created by Евгений Стафеев on 04.02.2023.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
