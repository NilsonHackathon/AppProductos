//
//  AnexarProductoViewController.swift
//  AppProductos
//
//  Created by User-UAM on 10/28/24.
//

import UIKit

class AnexarProductoViewController: UIViewController {
    
    
    @IBOutlet weak var tituloTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var precioTextField: UITextField!
    @IBOutlet weak var existenciaTextField: UITextField!
    
    private let anexarProductosController = AnexarProductoController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Añadir producto"
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func buttonAgregarProductAction(_ sender: Any) {
        guard let titulo = tituloTextField.text,
              let desciption = descriptionTextField.text,
              let precio = precioTextField.text,
              let stock = existenciaTextField.text
        else {
            return
        }
        
        let product = ProductModel(id: nil, title: titulo, description: desciption, price: Double(precio) ?? 0, stock: Double(stock) ?? 0, thumbnail: "")
        
        Task {
            let resultado = await anexarProductosController.createProduct(product)
            
            if resultado {
                navigationController?.popViewController(animated: true)
            }else{
                let alert = UIAlertController(title: "Creation product failure", message: "There was an error on the product.", preferredStyle: .alert)
                
                let action = UIAlertAction(title: "OK", style: .cancel)
                alert.addAction(action)
                
                present(alert, animated: true)
            }
        }
    }
}
