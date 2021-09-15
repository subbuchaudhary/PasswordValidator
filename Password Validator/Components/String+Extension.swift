//
//  String+Extension.swift
//  Password Validator
//
//  Created by Nelakudhiti, Subba on 9/14/21.
//

import Foundation

public extension String {
    func hasUpperCasedCharacters() -> Bool {
        return stringFulfillsRegex(regex: ".*[A-Z]+.*")
    }
    
    func hasLowerCasedCharacters() -> Bool {
        return stringFulfillsRegex(regex: ".*[a-z]+.*")
    }
    
    func hasNumbers() -> Bool {
        return stringFulfillsRegex(regex: ".*[0-9]+.*")
    }
    
    func hasSpecialCharacters() -> Bool {
        return stringFulfillsRegex(regex: ".*[^A-Za-z0-9].*")
    }
    
    private func stringFulfillsRegex(regex: String) -> Bool {
        let text = NSPredicate(format: "SELF MATCHES %@", regex)
        return text.evaluate(with: self)
    }
}
