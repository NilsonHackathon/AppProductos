//
//  ViewController.swift
//  AppProductos
//
//  Created by User-UAM on 10/18/24.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    private let loginController = LoginController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func loginButtonAction(_ sender: Any) {
        guard
            let username = usernameTextField.text,
            let password = passwordTextField.text
        else { return }
        
        Task{
            let response = await loginController.login(username: username, password: password)
            
            if response != nil {
                performSegue(withIdentifier: "goToMainView", sender: self)
            }else{
                let alert = UIAlertController(title: "Login failured", message: "There was an error loggin in", preferredStyle: .alert)
                
                let action = UIAlertAction(title: "ok", style: .cancel)
                alert.addAction(action)
                
                present(alert, animated: true)
            }
            
           }
    }
    
}

