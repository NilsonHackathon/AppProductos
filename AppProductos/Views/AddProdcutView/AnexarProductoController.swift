//
//  AnexarProductoController.swift
//  AppProductos
//
//  Created by User-UAM on 10/28/24.
//

import Foundation

final class AnexarProductoController {
    private let apiDataSource = ApiDataSource()
    
    func createProduct(_ product: ProductModel) async -> Bool {
        await apiDataSource.createProduct(product)
    }
}
