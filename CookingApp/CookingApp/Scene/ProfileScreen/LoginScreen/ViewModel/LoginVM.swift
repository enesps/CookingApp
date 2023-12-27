//
//  LoginVM.swift
//  CookingApp
//
//  Created by Enes Pusa on 27.12.2023.
//

import Foundation
import Combine
class LoginVM {
    @Published var username: String = ""
    @Published var password: String = ""
    
    var isLoginButtonEnabled: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest($username, $password)
            .map { username, password in
                return !username.isEmpty && !password.isEmpty && password.count >= 1
            }
            .eraseToAnyPublisher()
    }}
