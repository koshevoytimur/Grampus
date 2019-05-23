//
//  SignUpViewController.swift
//  Grampus
//
//  Created by MacBook Pro on 5/21/19.
//  Copyright © 2019 Тимур Кошевой. All rights reserved.
//

import UIKit
import ValidationComponents

class SignUpViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var _userName: UITextField!
    @IBOutlet weak var _email: UITextField!
    @IBOutlet weak var _password: UITextField!
    
    let predicate = EmailValidationPredicate()
    
    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    @IBAction func SignUpButton(_ sender: UIButton) {
        //let userName = _userName.text
        //let password = _password.text
        let email    = _email.text
        
        let emailFormatBool = predicate.evaluate(with: email)
        
        // Email isEmpty check.
        if (email!.isEmpty) {
            showAlert("Incorrect input", "Enter Email!")
            
            return
        } else {
            // Email validation.
            if (!emailFormatBool) {
                showAlert("Incorrect input", "Email format not correct!")
                
                return
            }
        }
        
        // Check lenght of password
        if let password = _password.text {
            if password.count < 6 {
                showAlert("Password too short", "Password shoud be more than 5 characters!")
            } else if password.count >= 24 {
                showAlert("Password too long", "Password shoud be less then 24 symbols")
            }
        }
        
        // Check lenght of user name
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
