//
//  ValidationType.swift
//  Password Validator
//
//  Created by Nelakudhiti, Subba on 9/14/21.
//

import Foundation

enum ValidationType {
    case notEmpty
    case minCharacters(count: Int)
    case specialCharacter
    case upperCaseLetters
    case lowerCaseLetters
    case numbers
    
    func validate(text: String) -> Bool {
        switch self {
        case .notEmpty: return !text.isEmpty
        case .minCharacters(count: let minCount): return text.count > minCount
        case .specialCharacter: return text.hasSpecialCharacters()
        case .upperCaseLetters: return text.hasUpperCasedCharacters()
        case .lowerCaseLetters: return text.hasLowerCasedCharacters()
        case .numbers: return text.hasNumbers()
        }
    }
    
    func errorMessage(for field: String) -> String {
        switch self {
        case .notEmpty: return "\(field) must not be empty"
        case .minCharacters(count: let minCount): return "\(field) must be longer than \(minCount) characters"
        case .specialCharacter: return "\(field) must have special characters"
        case .upperCaseLetters: return "\(field) must have upper case letters"
        case .lowerCaseLetters: return "\(field) must have lower case letters"
        case .numbers: return "\(field) must have numbers"
        }
    }
}
