//
//  ContentView.swift
//  SignUpForm
//
//  Created by Peter Friese on 27.12.21.
//
// Julianne http://github.com/iosjulianne
/*
 Exercises:
 1. Implement a password length requirement: make sure the user’s password has at least eight characters. If it has less than eight characters, display a warning in the footer of the password section of the form.
 2. Verify the password strength and reject any passwords that aren’t strong enough. An easy way to do this is to use a library like Navajo-Swift, which computes the strength on a scale of very weak, weak, reasonable, strong, very strong. Make sure the sign-up form only becomes valid if the user picks password with at least reasonable strength.
 3. Add a progress bar to the footer of the password section and display the password strength, coloring the progress bar in red, yellow, and green to indicate the password strength.
 */

import SwiftUI
import Combine
import Navajo_Swift

// MARK: - View Model
private class SignUpFormViewModel: ObservableObject {
    
    // MARK: Input
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var passwordConfirmation: String = ""
    
    // MARK: Output
    @Published var usernameMessage: String = ""
    @Published var passwordMessage: String = ""
    @Published var isValid: Bool = false
    
    // MARK: Username validattion
    private lazy var isUsernameLengthValidPublisher: AnyPublisher<Bool, Never>  = {
        $username
            .map { $0.count >= 3 }
            .eraseToAnyPublisher()
    }()
    
    // MARK: Password validation
    private lazy var isPasswordLengthValidPublisher: AnyPublisher<Bool, Never> = {
        $password
            .map{ $0.count <= 8 }
            .eraseToAnyPublisher()
    }()
    
    private lazy var isPasswordMatchingPublisher: AnyPublisher<Bool, Never> = {
        Publishers.CombineLatest($password, $passwordConfirmation)
            .map(==)
        // equivalent to
        // .map { $0 == $1 }
            .eraseToAnyPublisher()
    }()
    
    
    // 2. Verify the password strength and reject any passwords that aren’t strong enough.
    private lazy var isPasswordStrongPublisher: AnyPublisher<Bool, Never> = {
        $password
            .map{ Navajo.strength(ofPassword: $0) }
            .map{ passwordStrength in
                switch passwordStrength {
                case .reasonable, .strong, .veryStrong:
                    return true
                case .weak, .veryWeak:
                    return false
                }
            }
            .eraseToAnyPublisher()
    }()
    
    private lazy var isPasswordValidPublisher: AnyPublisher<Bool, Never> = {
        Publishers.CombineLatest3(isPasswordLengthValidPublisher, isPasswordMatchingPublisher, isPasswordStrongPublisher)
            .map { !$0 && $1 && $2 }
            .eraseToAnyPublisher()
    }()
    
    // MARK: Form validation
    private lazy var isFormValidPublisher: AnyPublisher<Bool, Never> = {
        Publishers.CombineLatest(isUsernameLengthValidPublisher, isPasswordValidPublisher)
            .map { $0 && $1 }
            .eraseToAnyPublisher()
    }()
    
    init() {
        isFormValidPublisher
            .assign(to: &$isValid)
        
        isUsernameLengthValidPublisher
            .map { $0 ? "" : "Username too short. Needs to be at least 3 characters." }
            .assign(to: &$usernameMessage)
        
        Publishers.CombineLatest(isPasswordLengthValidPublisher, isPasswordMatchingPublisher)
            .map { isPasswordLengthValid, isPasswordMatching in
                if isPasswordLengthValid {
                    return "Password is too short. Needs to be at least 8 characters."
                }
                else if !isPasswordMatching {
                    return "Passwords do not match"
                }
                return ""
            }
            .assign(to: &$passwordMessage)
    }
}

// MARK: - View
struct SignUpForm: View {
    @StateObject private var viewModel = SignUpFormViewModel()
    
    var body: some View {
        Form {
            // Username
            Section {
                TextField("Username", text: $viewModel.username)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            } footer: {
                Text(viewModel.usernameMessage)
                    .foregroundColor(.red)
            }
            
            // Password
            Section {
                SecureField("Password", text: $viewModel.password)
                SecureField("Repeat password", text: $viewModel.passwordConfirmation)
            } footer: {
                Text(viewModel.passwordMessage)
                    .foregroundColor(.red)
            }
            
            // Submit button
            Section {
                Button("Sign up") {
                    print("Signing up as \(viewModel.username)")
                }
                .disabled(!viewModel.isValid)
            }
        }
    }
}

// MARK: - Preview
struct SignUpForm_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SignUpForm()
                .navigationTitle("Sign up")
        }
    }
}
