//
//  ProductModel.swift
//  AppProductos
//
//  Created by User-UAM on 10/27/24.
//

import Foundation

struct ProductResponse: Decodable {
    let products: [ProductModel]
}

struct ProductModel: Hashable, Decodable, Encodable {
    let id: Int?
    let title: String
    let description: String
    let price: Double
    let stock: Double
    let thumbnail: String
}
