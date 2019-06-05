//
//  RatingViewController.swift
//  Grampus
//
//  Created by Тимур Кошевой on 5/21/19.
//  Copyright © 2019 Тимур Кошевой. All rights reserved.
//

// like_best_looker

import UIKit
import Alamofire
import SwiftyJSON

class RatingViewController: UIViewController, ModalViewControllerDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var _navigationBar: UINavigationBar!
    @IBOutlet weak var _menuBarButton: UIBarButtonItem!
    @IBOutlet weak var _searchBar: UISearchBar!
    @IBOutlet weak var _tableView: UITableView!
    
    let names = ["adsad", "fdsfdsfdsf", "Barack Obama"]
    let API_URL = "http://10.11.1.169:8080/api/profiles/all"
    
    var json: JSON!
    
    // MARK: - Functions
    
    override func loadView() {
        super.loadView()
        
//        fetchAllUsers()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _tableView.delegate = self
        _tableView.dataSource = self
        
        navBarAppearance()
        
        if revealViewController() != nil {
            _menuBarButton.target = self.revealViewController()
            _menuBarButton.action = #selector(SWRevealViewController().revealToggle(_:))
            
            self.view.addGestureRecognizer(revealViewController().panGestureRecognizer())
        }
    }
    
    func navBarAppearance() {
        _navigationBar.barTintColor = UIColor.darkText
        _navigationBar.tintColor = UIColor.white
    }
    
    func chooseLikeOrDislike( bool: Bool ) {
        let def = UserDefaults.standard
        def.set(bool, forKey: "like")
        def.synchronize()
    }
    
    // Actions
    @IBAction func likeButtonAction(_ sender: Any) {
        chooseLikeOrDislike( bool: true )
        
        self.performSegue(withIdentifier: "ShowModalView", sender: self)
        
        self.definesPresentationContext = true
        self.providesPresentationContextTransitionStyle = true
        
        self.overlayBlurredBackgroundView()
    }
    
    @IBAction func dislikeButtonAction(_ sender: Any) {
        chooseLikeOrDislike(bool: false)
        
        self.performSegue(withIdentifier: "ShowModalView", sender: self)
        
        self.definesPresentationContext = true
        self.providesPresentationContextTransitionStyle = true
        
        self.overlayBlurredBackgroundView()
    }
    
    func overlayBlurredBackgroundView() {
        
        let blurredBackgroundView = UIVisualEffectView()
        
        blurredBackgroundView.frame = view.frame
        blurredBackgroundView.effect = UIBlurEffect(style: .regular)
        
        view.addSubview(blurredBackgroundView)
        
    }
    
    func removeBlurredBackgroundView() {
        
        for subview in view.subviews {
            if subview.isKind(of: UIVisualEffectView.self) {
                subview.removeFromSuperview()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "ShowModalView" {
                if let viewController = segue.destination as? ModalViewController {
                    viewController.delegate = self
                    viewController.modalPresentationStyle = .overFullScreen
                }
            }
        }
    }
    
}

extension RatingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ratingCell", for: indexPath) as! RatingTableViewCell
        
        if let id = self.json[0]["id"].int {
            print(id)
        } else {
            print("HERE WE GO AGAIN 1")
        }
        
        if let userName = self.json[0]["user"]["username"].string {
            print(userName)
            cell._nameLabelCell.text = userName
        } else {
            print("HERE WE GO AGAIN 2")
        }
        
        if let jobTitle = self.json[0]["user"]["jobTitle"].string {
            print(jobTitle)
        } else {
            print("HERE WE GO AGAIN 3")
        }
        
        if let profilePicture = self.json[0]["profilePicture"].string {
            print(profilePicture)
        } else {
            print("HERE WE GO AGAIN 4")
        }
        
        
        
        
        
        return cell
    }
    
}
