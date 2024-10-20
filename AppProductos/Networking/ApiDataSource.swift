//
//  ApiDataSource.swift
//  AppProductos
//
//  Created by User-UAM on 10/19/24.
//

import Foundation
import UIKit

final class ApiDataSource {
    private let host = "https://dummyjson.com"
    
    func logIn(username: String, password: String) async -> LoginResponse? {
        
        guard let url = URL(string: "\(host)/auth/login") else {return nil}
        
        do {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
            
            let loginData = [
                "username": username,
                "password": password,
            ]
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: loginData, options: [])
            
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else { return nil }
            
            let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
            
            return loginResponse
            
        } catch {
            return nil
        }
    }
}
