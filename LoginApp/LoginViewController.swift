//
//  LoginViewController.swift
//  LoginApp
//
//  Created by Sunita Moond on 30/06/17.
//  Copyright © 2017 Sunita Moond. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userNameTextField: UITextField! {
        didSet {
            userNameTextField.delegate = self
        }
    }
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.delegate =  self
        }
    }
    @IBOutlet weak var loginButton: UIButton! {
        didSet {
            loginButton.isEnabled = false
            loginButton.alpha = 0.5
            loginButton.backgroundColor = UIColor.gray
            loginButton.layer.cornerRadius = 10
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        if let image =  UIImage(named: "nssl0091.png") {
        //            self.view.backgroundColor = UIColor(patternImage: image)
        //        }
    }
    
    fileprivate func showAlertViewController(title: String, message: String) {
        let alertController = UIAlertController(title: title,  message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title:"OK",style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true)
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        guard  let username = userNameTextField.text, !username.isEmpty else {
            showAlertViewController(title: "Invalid", message: "first fill credential")
            
            return
        }
        guard let getUser = UserDefaults.standard.object(forKey: username) as? [String : String] else {
            showAlertViewController(title: "Invalid", message: "Enter Correct Email for Login")
            
            return
        }
        if getUser[UserDefaultKeys.password] == passwordTextField.text {
            let userDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "UserDetailViewController") as! UserDetailViewController
            userDetailViewController.userName = userNameTextField.text
            self.navigationController?.pushViewController(userDetailViewController, animated: true)
        } else {
            showAlertViewController(title: "Invalid", message: "Enter Correct Email or Password")
        }
    }
    
    func toggleLoginButton(enabled: Bool) {
        loginButton.isEnabled = enabled
        loginButton.backgroundColor = enabled ? UIColor.green : UIColor.gray
    }
}
extension LoginViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard userNameTextField.text?.isEmpty == true || passwordTextField.text?.isEmpty == true else {
            toggleLoginButton(enabled: true)
            
            return true
        }
        toggleLoginButton(enabled: false)
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            // call login
            loginButtonTapped(loginButton)
        }
        
        return true
    }
}
