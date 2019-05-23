//
//  RatingViewController.swift
//  Grampus
//
//  Created by Тимур Кошевой on 5/21/19.
//  Copyright © 2019 Тимур Кошевой. All rights reserved.
//

import UIKit

class RatingViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var _navigationBar: UINavigationBar!
    @IBOutlet weak var _menuBarButton: UIBarButtonItem!
    @IBOutlet weak var _searchBar: UISearchBar!
    @IBOutlet weak var _tableView: UITableView!
    
    let names = ["adsad", "fdsfdsfdsf", "Barack Obama"]
    
    // MARK: - Functions
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
    
}

extension RatingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseCell", for: indexPath) as! RatingTableViewCell
        
        cell._nameLabelCell.text = names[indexPath.row]
        
        return cell
    }
    
}
