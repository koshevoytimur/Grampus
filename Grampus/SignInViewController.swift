//
//  ViewController.swift
//  Grampus
//
//  Created by Тимур Кошевой on 5/20/19.
//  Copyright © 2019 Тимур Кошевой. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var _userName: UITextField!
    @IBOutlet weak var _password: UITextField!
    
    @IBOutlet weak var _signInButton: UIButton!
    @IBOutlet weak var _signUpButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func SignInButton(_ sender: UIButton) {
        let userName = _userName.text
        let password = _password.text
        
        if (userName == "" || password == "") {
            return
        }
        
        if (userName == "test@test.com" && password == "test") {
            
        }
    }
    
    
    
    
}

