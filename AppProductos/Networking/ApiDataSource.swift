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
        
        guard let url = URL(string: "\(host)/auth/login") else { return nil }
        
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
            
            saveToken(loginResponse.accessToken)
            
            return loginResponse
            
        } catch {
            return nil
        }
    }
    
    func llamarProductos(query: String) async -> [ProductModel]? {
        var urlComponentes = URLComponents(string: "\(host)/auth/products/search")
        urlComponentes?.queryItems = [
            URLQueryItem(name: "q", value: query)
        ]
        
        guard let url = urlComponentes?.url, let token = getToken() else { return nil }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        do {
           let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard
                let urlResponse = response as? HTTPURLResponse, urlResponse.statusCode == 200
            else {
                return nil
            }
            
            let productResponse = try JSONDecoder().decode(ProductResponse.self, from: data)
            
            return productResponse.products
                    
        } catch {
            return nil
        }
    }
    
    
    func cargarFoto(url: String) async -> UIImage? {
        guard let url = URL(string: url) else {
            return nil
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard
                let urlResponse = response as? HTTPURLResponse, urlResponse.statusCode == 200
            else{
                return nil
            }
            
            let image = UIImage(data: data)
            
            return image
        }catch {
            return nil
        }
    }
    
    func createProduct(_ product: ProductModel) async -> Bool {
        guard let url = URL(string: "\(host)/auth/products/add"),
              let token = getToken()
        else{
            return false
        }
        
        do {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "POST"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
            urlRequest.httpBody = try JSONEncoder().encode(product)
            
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard let urlResponse = response as? HTTPURLResponse, urlResponse.statusCode == 201
            else{
                return false
            }
            
            return true
        }
        catch{
            return false
        }
    }
    
    private func saveToken(_ token: String) {
        UserDefaults.standard.set(token, forKey: "token")
    }
    
    private func getToken()-> String? {
        UserDefaults.standard.string(forKey: "token")
    }
}
