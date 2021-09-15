//
//  Validation.swift
//  Password Validator
//
//  Created by Nelakudhiti, Subba on 9/14/21.
//

import Foundation

struct Validation: Identifiable {
    var id: Int
    var textFieldType: FieldType
    var validationType: ValidationType
    var validationState: ValidationState
    
    init(text: String, id: Int, textFieldType: FieldType, validationType: ValidationType) {
        self.id = id
        self.textFieldType = textFieldType
        self.validationType = validationType
        self.validationState = validationType.validate(text: text) ? .valid : .notValid
    }
}
