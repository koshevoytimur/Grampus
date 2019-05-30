//
//  SignUpViewController.swift
//  Grampus
//
//  Created by MacBook Pro on 5/21/19.
//  Copyright © 2019 Тимур Кошевой. All rights reserved.
//

import UIKit
import ValidationComponents

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var _userName: UITextField!
    @IBOutlet weak var _email: UITextField!
    @IBOutlet weak var _password: UITextField!
    @IBOutlet weak var _signUpButton: UIButton!
    
    let predicate = EmailValidationPredicate()
    let alert = AlertView()
    let API_URL: String = "http://10.11.1.83:8080/api/users/register"
    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _userName.delegate = self
        _email.delegate = self
        _password.delegate = self
        
        SetUpOutlets()
        dismissKeyboardOnTap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeNotifications()
    }
    
    func fetch(url: String, method: Methods, data: [String: Any] = ["0": "0"], callback: @escaping (_ data: Any) -> ()) {
        guard let url = URL(string: url) else { return }
        
        var request = URLRequest(url: url)
        
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = method.rawValue
        
        print(method.rawValue)
        
        if (method != .get) {
            let jsonData = try! JSONSerialization.data(withJSONObject: data, options: [])
            request.httpBody = jsonData
        }
        
        let session = URLSession.shared
        
        session.dataTask(with: request) { (data, response, error) in
            if let response = response as? HTTPURLResponse {
                self.alert.showAlert(view: self, title: "Status Code", message: "\(response.statusCode)")
            }
            
            guard let data = data else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                callback(json)
            } catch {
                print(error)
            }
            
            }.resume()
    }
    
    let jsonEx: [String : Any] = [
        "username": "aaaa1@email.com",
        "password": "password",
        "fullName": "aaa"
    ]
    
    func SetUpOutlets() {
        
        _userName.layer.shadowColor = UIColor.darkGray.cgColor
        _userName.layer.shadowOffset = CGSize(width: 3, height: 3)
        _userName.layer.shadowRadius = 5
        _userName.layer.shadowOpacity = 0.5
        
        _password.layer.shadowColor = UIColor.darkGray.cgColor
        _password.layer.shadowOffset = CGSize(width: 3, height: 3)
        _password.layer.shadowRadius = 5
        _password.layer.shadowOpacity = 0.5
        
        _email.layer.shadowColor = UIColor.darkGray.cgColor
        _email.layer.shadowOffset = CGSize(width: 3, height: 3)
        _email.layer.shadowRadius = 5
        _email.layer.shadowOpacity = 0.5
        
        _signUpButton.layer.shadowColor = UIColor.darkGray.cgColor
        _signUpButton.layer.shadowOffset = CGSize(width: 3, height: 3)
        _signUpButton.layer.shadowRadius = 5
        _signUpButton.layer.shadowOpacity = 0.5
        
        _signUpButton.layer.cornerRadius = 5
        
    }
    
    // Notifications for moving view when keyboard appears.
    func setUpNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // Removing notifications.
    func removeNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillHide() {
        self.view.frame.origin.y = 0
    }
    
    @objc func keyboardWillChange(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if _userName.isFirstResponder {
                self.view.frame.origin.y = -keyboardSize.height + 100
            } else if _email.isFirstResponder {
                self.view.frame.origin.y = -keyboardSize.height + 100
            } else if _password.isFirstResponder {
                self.view.frame.origin.y = -keyboardSize.height + 100
            }
        }
    }
    
    // MARK: - Actions
    @IBAction func SignUpButton(_ sender: UIButton) {
        
        fetch(url: (API_URL) , method: .post, data: jsonEx, callback: {(data: Any) -> Void in
            print(data)
        })
        
//        //let userName = _userName.text
//        //let password = _password.text
//        let email    = _email.text
//
//        let emailFormatBool = predicate.evaluate(with: email)
//
//        // Check lenght of user name
//        if let userName = _userName.text {
//            if userName.count < 2 {
//                showAlert("Name too short", "Write your correct name")
//            }
//        }
//
//        // Email isEmpty check.
//        if (email!.isEmpty) {
//            showAlert("Incorrect input", "Enter Email!")
//
//            return
//        } else {
//            // Email validation.
//            if (!emailFormatBool) {
//                showAlert("Incorrect input", "Email format not correct!")
//
//                return
//            }
//        }
//
//        // Check lenght of password
//        if let password = _password.text {
//            if password.count < 6 {
//                showAlert("Password too short", "Password shoud be more than 5 characters!")
//            } else if password.count >= 24 {
//                showAlert("Password too long", "Password shoud be less then 24 symbols")
//            }
//        }
    }
    
    func showAlert(_ title: String, _ message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    // Hide keyboard on tap.
    func dismissKeyboardOnTap() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    // Hide Keyboard.
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // Hide the keyboard when the return key pressed.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
