//
//  LogInViewController.swift
//  toDoListApp
//
//  Created by Rafael Asencio on 24/10/2018.
//  Copyright © 2018 Rafael Asencio. All rights reserved.
//

import UIKit
import Firebase
//import SVProgressHUD

class LogInViewController: UIViewController {

    
    @IBOutlet weak var emailTextFieldLogin: UITextField!
    
    @IBOutlet weak var passwordTextFieldLogin: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func loginButton(_ sender: UIButton) {
        
        FIRAuth.auth()?.signIn(withEmail: emailTextFieldLogin.text!, password: passwordTextFieldLogin.text!, completion: { (user, error) in
            
            //SVProgressHUD.show()
            
            if error != nil {
    
                print(error!)
                
            } else {
                print("Login Sucessfull")
                
                //SVProgressHUD.dismiss()
                
                self.performSegue(withIdentifier: "goToApp2", sender: self) }
        })
    }
    
}
