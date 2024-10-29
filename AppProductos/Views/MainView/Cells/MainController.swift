//
//  MainController.swift
//  AppProductos
//
//  Created by User-UAM on 10/27/24.
//

import Foundation
import UIKit

final class MainController {
    private let apiDataSource = ApiDataSource()
    
    func tomarProducto(query: String = "") async -> [ProductModel]? {
        await apiDataSource.llamarProductos(query: query)
    }
    
    func loadImage(url: String) async -> UIImage? {
        await apiDataSource.cargarFoto(url: url)
    }
}
