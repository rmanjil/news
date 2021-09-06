//
//  String.swift
//  NewApp
//
//  Created by manjil on 06/09/2021.
//

import Foundation

extension String {
    var trim: String {
        self.trimmingCharacters(in: .whitespaces)
    }
    
    func attributeText(attribute: [NSAttributedString.Key: Any]) -> NSAttributedString {
        return NSAttributedString(string: self, attributes: attribute)
    }
}
