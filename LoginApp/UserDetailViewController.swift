//
//  UserDetailViewController.swift
//  LoginApp
//
//  Created by Sunita Moond on 30/06/17.
//  Copyright © 2017 Sunita Moond. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {
    var userName :String?
    @IBOutlet weak var userEmail: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if let image =  UIImage(named: "nssl0042.png") {
//            self.view.backgroundColor = UIColor(patternImage: image)
//        }
        guard let email = userName else{ return }
        guard let getUser = UserDefaults.standard.object(forKey: email) as? [String : String] else { return }
        guard let firstName = getUser[UserDefaultKeys.firstName] ,let lastName = getUser[UserDefaultKeys.lastName]
            else { return }
        userEmail.text = "Welcome" + " " + firstName + " " + lastName
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
