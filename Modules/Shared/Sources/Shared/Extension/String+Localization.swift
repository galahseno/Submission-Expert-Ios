//
//  String+Localization.swift
//
//
//  Created by Galah Seno on 14/03/24.
//

import Foundation

extension String {
    public func localized() -> String {
        let bundle = Bundle.module 
        return bundle.localizedString(forKey: self, value: nil, table: nil)
    }
}
