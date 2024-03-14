//
//  String+Localization.swift
//
//
//  Created by Galah Seno on 14/03/24.
//

import Foundation

extension String {
    public func localized(identifier: String) -> String {
        let bundle = Bundle(identifier: identifier) ?? .main
        return bundle.localizedString(forKey: self, value: nil, table: nil)
    }
}
