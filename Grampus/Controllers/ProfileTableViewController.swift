//
//  ProfileTableViewController.swift
//  Grampus
//
//  Created by Тимур Кошевой on 5/23/19.
//  Copyright © 2019 Тимур Кошевой. All rights reserved.
//

import UIKit
import Alamofire

class ProfileTableViewController: UITableViewController {
    
    @IBOutlet weak var _menuBarButton: UIBarButtonItem!
    @IBOutlet weak var _navigationBar: UINavigationBar!
    
    //Overview cell
    @IBOutlet weak var _profileImageView: UIImageView!
    @IBOutlet weak var _profileFullNameLabel: UILabel!
    @IBOutlet weak var _profileProfessionLabel: UILabel!
    @IBOutlet weak var _profileLikeLabel: UILabel!
    @IBOutlet weak var _profileDislikeLabel: UILabel!
    
    //Achievement cell
    
    //Information cell
    @IBOutlet weak var _profileInformationLabel: UILabel!
    //Skills cell
    @IBOutlet weak var _profileSkillsLabel: UILabel!
    
    let alert = AlertView()
    //let API_URL: String = "http://10.11.1.169:8080/api/profiles/all"
    
    override func loadView() {
        super.loadView()
        
        fetchUserInformation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navBarAppearance()
        //        _profileInformationLabel.numberOfLines = 0
        //        _profileSkillsLabel.numberOfLines = 0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
        
        //self.tableView.tableFooterView = UIView(frame: .zero)
        
        _navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        if revealViewController() != nil {
            _menuBarButton.target = self.revealViewController()
            _menuBarButton.action = #selector(SWRevealViewController().revealToggle(_:))
            
            self.view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        }
    }
    
    func fetchUserInformation() {
        let def = UserDefaults.standard
        
        let token = def.string(forKey: "token")
        let userId = def.string(forKey: "userId")
        
        let API_URL: String = "http://10.11.1.169:8080/api/profiles/\(userId!)"
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json; charset=utf-8",
            "Authorization": "Bearer \(token!)"
        ]
        
        Alamofire.request(API_URL, method: .get, encoding: JSONEncoding.default, headers: headers).validate().responseJSON { responseJSON in
            
            switch responseJSON.result {
            case .success :
                
                if let result = responseJSON.result.value {
                    let JSON = result as! NSDictionary
                    
                    let user = JSON["user"] as! NSDictionary
                    
                    print("NSDictionary")
                    print(JSON)
                    print("USER")
                    print(user)
                    
                    let fullName = user["fullName"] as! String
                    let profession = user["jobTitle"] as! String
                    let likes = JSON["likes"] as! Int
                    let dislikes = JSON["dislikes"] as! Int
                    
                    self.setUpOverviewCell(fullName: fullName, profession: profession, likes: likes, dislikes: dislikes)
                }
                
                //                print(responseJSON.data)
                //                print(responseJSON.result)
                //                print(responseJSON.value)
                
            case .failure(let error) :
                print(error)
            }
        }
    }
    
    func setUpOverviewCell( fullName: String, profession: String, likes: Int, dislikes: Int) {
        
        _profileFullNameLabel.text = fullName
        _profileProfessionLabel.text = profession
        _profileLikeLabel.text = String(describing: likes)
        _profileDislikeLabel.text = String(describing: dislikes) 
        self.tableView.reloadData()
    }
    
    func navBarAppearance() {
        _profileImageView.layer.cornerRadius = 50
        _profileImageView.layer.borderWidth = 1.5
        _profileImageView.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    // MARK: - Actions
    @IBAction func informationAddAction(_ sender: Any) {
        let alert = UIAlertController(title: "Enter information about yourself:", message: nil, preferredStyle: .alert)
        
        alert.addTextField { (textField) in
            textField.text = self._profileInformationLabel.text
        }
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            self._profileInformationLabel.text = textField?.text
            self.tableView.reloadData()
            
        }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
        self.tableView.reloadData()
    }
    
    @IBAction func skillsAddAction(_ sender: Any) {
        let alert = UIAlertController(title: "Enter your skills:", message: nil, preferredStyle: .alert)
        
        
        alert.addTextField { (textField) in
            textField.text = self._profileSkillsLabel.text
        }
        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            self._profileSkillsLabel.text = textField?.text
            self.tableView.reloadData()
            
        }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 2 || indexPath.row == 3 {
            return UITableView.automaticDimension
        } else if indexPath.row == 4{
            return 300.0
        } else {
            return 120.0
        }
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 2 || indexPath.row == 3 {
            return UITableView.automaticDimension
        } else {
            return 120.0
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
}














//    func fetch(url: String, method: Methods, data: [String: Any] = ["0": "0"], callback: @escaping (_ data: Any) -> ()) {
//        guard let url = URL(string: url) else { return }
//
//        var request = URLRequest(url: url)
//
//        let def = UserDefaults.standard
//        let token = def.string(forKey: "token")
//        print("TOKEN: \(token)")
//
//        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
//        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
//        request.addValue("Bearer \(token!)", forHTTPHeaderField: "Authorization")
//
//
//        request.httpMethod = method.rawValue
//
//        print(method.rawValue)
//
//        if (method != .get) {
//            let jsonData = try! JSONSerialization.data(withJSONObject: data, options: [])
//            request.httpBody = jsonData
//        }
//
//        let session = URLSession.shared
//
//        session.dataTask(with: request) { (data, response, error) in
//            if let response = response as? HTTPURLResponse {
//                if response.statusCode == 200 {
//                    print("Status CODE: \(response.statusCode)")
//                } else {
//                    self.alert.showAlert(view: self, title: "Status Code", message: "\(response.statusCode)")
//                    return
//                }
//            }
//
//            guard let data = data else { return }
//            do {
//                let json = try JSONSerialization.jsonObject(with: data, options: [])
//                callback(json)
//            } catch {
//                print(error)
//            }
//
//            }.resume()
//    }
