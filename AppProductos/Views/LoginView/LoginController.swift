//
//  LoginController.swift
//  AppProductos
//
//  Created by User-UAM on 10/19/24.
//

import Foundation
final class LoginController {
    private let apiDataSource = ApiDataSource()
    
    func login(username: String, password: String) async -> LoginResponse? {
        await apiDataSource.logIn(username: username, password: password)
    }
}
