//
//  LoginViewController.swift
//  LoginApp
//
//  Created by Sunita Moond on 30/06/17.
//  Copyright © 2017 Sunita Moond. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userNameUILabel: UILabel! {
        didSet {
            userNameUILabel.text = ""
        }
    }
    @IBOutlet weak var passwordUILabel: UILabel! {
        didSet {
            passwordUILabel.text = ""
        }
    }
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
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        guard  let username = userNameTextField.text, !username.isEmpty else {
            showAlertViewController(title: "Invalid", message:Message.fillAllTheCredential.message)
            
            return
        }
        guard let getUser = UserDefaults.standard.object(forKey: username) as? [String : String] else {
            showAlertViewController(message: Message.inValidEmail.message)
            
            return
        }
        if getUser[UserDefaultKeys.password] == passwordTextField.text {
            let userDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "UserDetailViewController") as! UserDetailViewController
            userDetailViewController.userName = userNameTextField.text
            self.navigationController?.pushViewController(userDetailViewController, animated: true)
        } else {
            showAlertViewController( message: Message.passwordMatch.message)
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
    enum message: String {
        case userName
        case password
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == userNameTextField ,let email = textField.text, !Validation.isValidEmail(email: email) {
            userNameUILabel.text = Message.inValidEmail.message
        } else {
            userNameUILabel.text = ""
        }
        
        
        if textField == passwordTextField ,let password = textField.text, !Validation.isValidPassword(password: password) {
            passwordUILabel.text = Message.inValidPassword.message
        } else {
            passwordUILabel.text = ""
        }
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
