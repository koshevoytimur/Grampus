//
//  ProfileTableViewController.swift
//  Grampus
//
//  Created by Тимур Кошевой on 5/23/19.
//  Copyright © 2019 Тимур Кошевой. All rights reserved.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navBarAppearance()
        _profileInformationLabel.numberOfLines = 0
        _profileSkillsLabel.numberOfLines = 0
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
    
    func navBarAppearance() {
        _profileImageView.layer.cornerRadius = 50
        _profileImageView.layer.borderWidth = 1.5
        _profileImageView.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 2 || indexPath.row == 3 {
            return UITableView.automaticDimension
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
    
}
