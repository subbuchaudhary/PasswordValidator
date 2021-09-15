//
//  ValidationFormViewModel.swift
//  Password Validator
//
//  Created by Nelakudhiti, Subba on 9/14/21.
//

import SwiftUI
import Combine

final class ValidationFormViewModel: ObservableObject {
    @Published var password = ""
    @Published var validations: [Validation] = []
    @Published var isValid: Bool = false
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    init() {
        passwordPublisher.receive(on: RunLoop.main)
            .assign(to: \.validations, on: self)
            .store(in: &cancellableSet)
        
        passwordPublisher.receive(on: RunLoop.main)
            .map { validations in
                return validations.filter { validation in
                    return ValidationState.notValid == validation.validationState
                }.isEmpty
            }
            .assign(to: \.isValid, on: self)
            .store(in: &cancellableSet)
    }
    
    private var passwordPublisher: AnyPublisher<[Validation], Never> {
        $password.removeDuplicates().map {
            var validations: [Validation] = []
            validations.append(Validation(text: $0, id: 0, textFieldType: .password, validationType: .notEmpty))
            validations.append(Validation(text: $0, id: 1, textFieldType: .password, validationType: .minCharacters(count: 8)))
            validations.append(Validation(text: $0, id: 2, textFieldType: .password, validationType: .specialCharacter))
            validations.append(Validation(text: $0, id: 3, textFieldType: .password, validationType: .upperCaseLetters))
            validations.append(Validation(text: $0, id: 4, textFieldType: .password, validationType: .lowerCaseLetters))
            validations.append(Validation(text: $0, id: 5, textFieldType: .password, validationType: .numbers))
            return validations
        }.eraseToAnyPublisher()
    }
}
