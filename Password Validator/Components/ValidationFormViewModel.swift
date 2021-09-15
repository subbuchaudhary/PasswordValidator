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
        // to check validations
        passwordPublisher.receive(on: RunLoop.main)
            .assign(to: \.validations, on: self)
            .store(in: &cancellableSet)
        // to check isValid or not
        passwordPublisher.receive(on: RunLoop.main)
            .map { validations in
                return validations.filter { validation in
                    return validation.validationState == .notValid
                }.isEmpty
            }
            .assign(to: \.isValid, on: self)
            .store(in: &cancellableSet)
    }
    
    private var passwordPublisher: AnyPublisher<[Validation], Never> {
        $password.removeDuplicates().map { [weak self] in
            let result = self?.strengthStatus($0) ?? ("", "No")
            print(result)
            print("isPasswordValid: \(result.1)")
            var validations: [Validation] = []
            validations.append(Validation(text: $0, id: 0, textFieldType: .password, validationType: .notEmpty))
            validations.append(Validation(text: $0, id: 1, textFieldType: .password, validationType: .minCharacters(count: 8))) // validation for password characters should have more than 8
            validations.append(Validation(text: $0, id: 2, textFieldType: .password, validationType: .specialCharacter))
            validations.append(Validation(text: $0, id: 3, textFieldType: .password, validationType: .upperCaseLetters))
            validations.append(Validation(text: $0, id: 4, textFieldType: .password, validationType: .lowerCaseLetters))
            validations.append(Validation(text: $0, id: 5, textFieldType: .password, validationType: .numbers))
            return validations
        }.eraseToAnyPublisher()
    }
    
    private func strengthStatus(_ text: String) -> (String, String) {
        var result: (String, String)
        if text.count > 10, text.hasStrength() {
            result = ("Strong", "Yes")
        } else if text.hasStrength() {
            result = ("Good", "Yes")
        } else if text.isEmpty {
            result = ("Didn't enter text yet", "No")
        } else {
            result = ("Poor", "No")
        }
        return result
    }
}
