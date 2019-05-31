//
//  ViewController.swift
//  Grampus
//
//  Created by Тимур Кошевой on 5/20/19.
//  Copyright © 2019 Тимур Кошевой. All rights reserved.
//

import UIKit
import JWTDecode


struct TokenData: Codable {
    
    let success: Bool?
    let token: String?

}

class SignInViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var _userName: UITextField!
    @IBOutlet weak var _password: UITextField!
    
    @IBOutlet weak var _signInButton: UIButton!
    @IBOutlet weak var _signUpButton: UIButton!
    
    let API_URL: String = "http://10.11.1.169:8080/api/users/login"
    let alert = AlertView()
    
    var tokenData: TokenData?
    
    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _userName.delegate = self
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
    
    func SetUpOutlets() {
        
        _userName.layer.shadowColor = UIColor.darkGray.cgColor
        _userName.layer.shadowOffset = CGSize(width: 3, height: 3)
        _userName.layer.shadowRadius = 5
        _userName.layer.shadowOpacity = 0.5
        
        _password.layer.shadowColor = UIColor.darkGray.cgColor
        _password.layer.shadowOffset = CGSize(width: 3, height: 3)
        _password.layer.shadowRadius = 5
        _password.layer.shadowOpacity = 0.5
        
        _signInButton.layer.shadowColor = UIColor.darkGray.cgColor
        _signInButton.layer.shadowOffset = CGSize(width: 3, height: 3)
        _signInButton.layer.shadowRadius = 5
        _signInButton.layer.shadowOpacity = 0.5
        
        _signUpButton.layer.shadowColor = UIColor.darkGray.cgColor
        _signUpButton.layer.shadowOffset = CGSize(width: 3, height: 3)
        _signUpButton.layer.shadowRadius = 5
        _signUpButton.layer.shadowOpacity = 0.5
        
        _signInButton.layer.cornerRadius = 5
        _signUpButton.layer.cornerRadius = 5
        
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
            } else if _password.isFirstResponder {
                self.view.frame.origin.y = -keyboardSize.height + 100
            }
        }
    }
    
    // MARK: - Actions
    @IBAction func SignInButton(_ sender: UIButton) {
        
        fetch(url: (API_URL) , method: .post, data: jsonEx, callback: {(data: Any) -> Void in
            print("DATA: ---------------- \(data)")
            
        })
        
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
                
                self.tokenData = try? JSONDecoder().decode(TokenData.self, from: data )
                print("TOKEN: ---------------- \(self.tokenData?.token)")
                
                let tokenWBearer = self.tokenData?.token
                let wordToRemove = "Bearer "
                let tokenWithOutBearer = tokenWBearer!.deletingPrefix(wordToRemove)
                let jwt = try decode(jwt: tokenWithOutBearer)
                print("Decoded jwt ----------------\(jwt)")
                
                callback(json)
            } catch {
                print(error)
            }
            
            }.resume()
    }
    
    
    
    let jsonEx: [String : Any] = [
        "username": "aaaa111@email.com",
        "password": "password"
//        "fullName": "aaa"
    ]
    
}

extension String {
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
}
