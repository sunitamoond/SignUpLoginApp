//
//  ViewController.swift
//  LoginApp
//
//  Created by Sunita Moond on 29/06/17.
//  Copyright © 2017 Sunita Moond. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var loginButton: UIButton! {
        didSet {
            loginButton.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var signUpButton: UIButton! {
        didSet {
            signUpButton.layer.cornerRadius = 10
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        //        if let image =  UIImage(named: "2_small.png") {
        //            self.view.backgroundColor = UIColor(patternImage: image)
        //        }
    }
}

