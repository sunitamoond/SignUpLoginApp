//
//  UIViewController+Extension.swift
//  LoginApp
//
//  Created by Sunita Moond on 05/07/17.
//  Copyright © 2017 Sunita Moond. All rights reserved.
//

import Foundation
import UIKit


enum Message: String {
    case empty
    case inValidEmail
    case inValidPassword
    case passwordMatch
    case fillAllTheCredential
    case signIn
    case signUp
    
    var message: String {
    switch self {
    case .empty:
        return "this field not be empty"
    case .inValidEmail:
        return "Email is invalid"
    case .inValidPassword:
        return "Password is invalid"
    case .passwordMatch:
        return "password and confirmpassword should be match"
    case .fillAllTheCredential:
        return "Fill all the credential"
    case .signIn:
        return "Enter correct email or password"
    case .signUp:
        return "this id already exist"
    }
    
}
}

extension UIViewController {
    func showAlertViewController(title :String = "invalid", message: String) {
        let alertController = UIAlertController(title: title,  message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title:"OK",style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true)
    }
}

