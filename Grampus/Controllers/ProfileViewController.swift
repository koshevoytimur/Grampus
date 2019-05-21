//
//  ProfileViewController.swift
//  Grampus
//
//  Created by Тимур Кошевой on 5/21/19.
//  Copyright © 2019 Тимур Кошевой. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var _navigationBar: UINavigationBar!
    @IBOutlet weak var _menuBarButton: UIBarButtonItem!
    
    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
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

}
