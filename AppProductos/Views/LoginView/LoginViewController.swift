//
//  ViewController.swift
//  AppProductos
//
//  Created by User-UAM on 10/18/24.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextFild: UITextField!
    
    private let loginController = LoginController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func loginButtonAction(_ sender: Any) {
        guard let username = usernameTextField.text,let password = passwordTextFild.text
        else {return}
        
        Task{
            let response = await loginController.login(username: username, password: password)
            
            if response != nil{
                performSegue(withIdentifier: "goToMainView", sender: self)
            }
        }
    }
    
}

