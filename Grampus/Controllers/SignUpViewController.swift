//
//  SignUpViewController.swift
//  Grampus
//
//  Created by MacBook Pro on 5/21/19.
//  Copyright © 2019 Тимур Кошевой. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var _userName: UITextField!
    @IBOutlet weak var _email: UITextField!
    @IBOutlet weak var _password: UITextField!
    
    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    @IBAction func SignUpButton(_ sender: UIButton) {
        //let userName = _userName.text
        //let password = _password.text
        //let email    = _email.text
        
        if let password = _password.text {
            if password.count < 6 {
                showAlert("Password too short", "Password must have more than 6 symbols")
            } else if password.count >= 24 {
                showAlert("Password too long", "Password must have lost then 24 symbols")
            }
        }
        
        if let userName = _userName.text {
            if userName.count < 2 {
                showAlert("Name too short", "Write your correct name")
            }
        }
        
        
    }
    
    func showAlert(_ title: String, _ message: String) {
    
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
    
        alert.addAction(action)
    
        present(alert, animated: true, completion: nil)
    
    }
    
    
    
    
    
}
