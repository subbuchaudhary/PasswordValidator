//
//  ContentView.swift
//  Password Validator
//
//  Created by Nelakudhiti, Subba on 9/14/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var userViewModel = ValidationFormViewModel()
    @State private var isPasswordVisible: Bool = false
    
    var body: some View {
        NavigationView {
            Form() {
                Section(header: Text("Enter Password here").font(.caption)) {
                    HStack {
                        if isPasswordVisible {
                            TextField("Password", text: $userViewModel.password)
                        } else {
                            SecureField("Password", text: $userViewModel.password)
                        }
                        
                        Spacer().frame(width: 10)
                        
                        Button(action: { }, label: {
                            Image(systemName: isPasswordVisible ? "eye" : "eye.slash")
                                .foregroundColor(isPasswordVisible ? .green : .gray)
                                .frame(width: 20, height: 20, alignment: .center)
                        })
                        .onTapGesture {
                            self.isPasswordVisible.toggle()
                        }
                    }
                    
                    List(userViewModel.validations) { validation in
                        HStack {
                            Image(systemName: validation.validationState == .valid ? "checkmark.circle.fill" : "checkmark.circle")
                                .foregroundColor(validation.validationState == .valid ? .green : .gray.opacity(0.3))
                            Text(validation.validationType.errorMessage(for: validation.textFieldType.rawValue))
                                .strikethrough(validation.validationState == .valid)
                                .font(.caption)
                                .foregroundColor(validation.validationState == .valid ? .gray : .black)
                        }
                        .padding([.leading], 15)
                    }
                }
                
                Section {
                    Button(action: {
                        // Action
                    }){
                        HStack(alignment: .center) {
                            Spacer()
                            Image(systemName: userViewModel.isValid ? "lock.open.fill" : "lock.fill")
                            Text("Create")
                            Spacer()
                        }
                    }
                    .disabled(!userViewModel.isValid)
                    .animation(.default)
                }
            }
            .listStyle(GroupedListStyle())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
