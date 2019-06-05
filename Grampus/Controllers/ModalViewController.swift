//
//  ModalViewController.swift
//  Grampus
//
//  Created by Тимур Кошевой on 6/5/19.
//  Copyright © 2019 Тимур Кошевой. All rights reserved.
//

import UIKit

protocol ModalViewControllerDelegate: class {
    func removeBlurredBackgroundView()
}

class ModalViewController: UIViewController {

    @IBOutlet weak var _firstButton: UIButton!
    @IBOutlet weak var _secondButton: UIButton!
    @IBOutlet weak var _thirdButton: UIButton!
    @IBOutlet weak var _cancelButton: UIButton!
    @IBOutlet weak var _okButton: UIButton!
    
    var selectedCategory: String?
    var likeState: Bool?
    
    weak var delegate: ModalViewControllerDelegate?
    
    override func loadView() {
        super.loadView()
        
        let def = UserDefaults.standard
        likeState = def.bool(forKey: "like")
        
        configureButtons()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewDidLayoutSubviews() {
        view.backgroundColor = UIColor.clear
        
//        //ensure that the icon embeded in the cancel button fits in nicely
//        cancelButton.imageView?.contentMode = .scaleAspectFit
//
//        //add a white tint color for the Cancel button image
//        let cancelImage = UIImage(named: "Cancel")
//
//        let tintedCancelImage = cancelImage?.withRenderingMode(.alwaysTemplate)
//        cancelButton.setImage(tintedCancelImage, for: .normal)
//        cancelButton.tintColor = .white
    }
    
    func configureButtons() {
        
        if likeState! {
            _firstButton.setTitle("Best Looker", for: .normal)
            _firstButton.layer.cornerRadius = 5
            _secondButton.setTitle("Super Worker", for: .normal)
            _secondButton.layer.cornerRadius = 5
            _thirdButton.setTitle("Extrovert", for: .normal)
            _thirdButton.layer.cornerRadius = 5
        } else {
            _firstButton.setTitle("Untidy", for: .normal)
            _firstButton.layer.cornerRadius = 5
            _secondButton.setTitle("Deadliner", for: .normal)
            _secondButton.layer.cornerRadius = 5
            _thirdButton.setTitle("Introvert", for: .normal)
            _thirdButton.layer.cornerRadius = 5
        }
        
        _cancelButton.layer.cornerRadius = 5
        _okButton.layer.cornerRadius = 5
    }
    
    @IBAction func firstAction(_ sender: Any) {
       
        if likeState! {
           selectedCategory = "like_best_looker"
        } else {
            selectedCategory = "dislike_untidy"
        }
        _firstButton.backgroundColor = UIColor.blue
        _secondButton.backgroundColor = UIColor.darkGray
        _thirdButton.backgroundColor = UIColor.darkGray
        print(selectedCategory)
    }
    
    @IBAction func secondAction(_ sender: Any) {
        
        if likeState! {
            selectedCategory = "like_super_worker"
        } else {
            selectedCategory = "dislike_deadliner"
        }
        _firstButton.backgroundColor = UIColor.darkGray
        _secondButton.backgroundColor = UIColor.blue
        _thirdButton.backgroundColor = UIColor.darkGray
        print(selectedCategory)
    }
    
    @IBAction func thirdAction(_ sender: Any) {
        
        if likeState! {
            selectedCategory = "like_extrovert"
        } else {
            selectedCategory = "dislike_introvert"
        }
        _firstButton.backgroundColor = UIColor.darkGray
        _secondButton.backgroundColor = UIColor.darkGray
        _thirdButton.backgroundColor = UIColor.blue
        print(selectedCategory)
    }
    
    @IBAction func okButtonAction(_ sender: Any) {
    
    }
    
    @IBAction func cancelButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        delegate?.removeBlurredBackgroundView()
    }
}
