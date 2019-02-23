//
//  RegisterViewController.swift
//  toDoListApp
//
//  Created by Rafael Asencio on 24/10/2018.
//  Copyright © 2018 Rafael Asencio. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    @IBAction func registerButton(_ sender: UIButton) {
        
        FIRAuth.auth()?.createUser(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
            if error != nil {
                print("\(error)")
            } else {
                print("Registration sucessfull!")
                
                self.performSegue(withIdentifier: "goToApp", sender: self)
            }
        } )
    }
    
    


}
