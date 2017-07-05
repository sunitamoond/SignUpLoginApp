//
//  SignUpViewController.swift
//  LoginApp
//
//  Created by Sunita Moond on 30/06/17.
//  Copyright © 2017 Sunita Moond. All rights reserved.
//

import UIKit
//import Foundation

class SignUpViewController: UIViewController {
    @IBOutlet weak var firstNameUILabel: UILabel! {
        didSet {
            firstNameUILabel.text = ""
        }
    }
    @IBOutlet weak var lastNameUILabel: UILabel! {
        didSet {
            lastNameUILabel.text = ""
        }
    }
    @IBOutlet weak var emailUILabel: UILabel! {
        didSet {
            emailUILabel.text = ""
        }
    }
    @IBOutlet weak var passwordUILabel: UILabel! {
        didSet {
            passwordUILabel.text = ""
        }
    }
    @IBOutlet weak var confirmPasswordUILabel: UILabel!
        {
        didSet {
            confirmPasswordUILabel.text = ""
        }
    }
    @IBOutlet weak var firstNameTextField: UITextField! {
        didSet {
            firstNameTextField.delegate = self
        }
    }
    @IBOutlet weak var lastNameTextField: UITextField! {
        didSet {
            lastNameTextField.delegate = self
        }
    }
    @IBOutlet weak var emailAddressTextField: UITextField! {
        didSet {
            emailAddressTextField.delegate = self
        }
    }
    @IBOutlet weak var passwordTextField: UITextField! {
        didSet {
            passwordTextField.delegate = self
        }
    }
    @IBOutlet weak var confirmPasswordTextField: UITextField! {
        didSet {
            confirmPasswordTextField.delegate = self
        }
    }
    @IBOutlet weak var signUpButton: UIButton! {
        didSet {
            signUpButton.isEnabled = false
            signUpButton.alpha = 0.5
            signUpButton.backgroundColor = UIColor.gray
            signUpButton.layer.cornerRadius = 10
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        if let image =  UIImage(named: "nssl0045.png") {
        //            self.view.backgroundColor = UIColor(patternImage: image)
        //        }
    }
    @IBAction func signUpButtonTapped(_ sender: Any) {
        
        guard let firstName = firstNameTextField.text,
            let lastName = lastNameTextField.text,
            let emailAddress = emailAddressTextField.text,
            let password = passwordTextField.text,
            let confirmPassword = confirmPasswordTextField.text else {
                showAlertViewController(message: Message.fillAllTheCredential.message)
                return
        }
        let flagEmail = Validation.isValidEmail(email: emailAddress)
        if flagEmail == false {
            showAlertViewController( message: Message.inValidEmail.message)
        }
        let flagPassword  = Validation.isValidPassword(password: password)
        if flagPassword == false {
            showAlertViewController(message: Message.inValidPassword.message)
        }
        if confirmPassword != password {
            showAlertViewController(message: Message.passwordMatch.message)
        }
        if (UserDefaults.standard.object(forKey: emailAddress) as? [String: String]) != nil {
            showAlertViewController(message: Message.signUp.message)
            
            return
        } else {
            let dictionary = [UserDefaultKeys.firstName: firstName,
                              UserDefaultKeys.lastName: lastName,
                              UserDefaultKeys.emailAddress : emailAddress,
                              UserDefaultKeys.password: password ]
            UserDefaults.standard.set(dictionary, forKey: emailAddress)
            
            return
        }
    }
    
    func toggleSignUpButton(enabled: Bool) {
        // Signup Button Enable or Disable
        if enabled == true {
            signUpButton.isEnabled = enabled
            signUpButton.backgroundColor = UIColor.green
        } else{
            signUpButton.isEnabled = enabled
            signUpButton.backgroundColor = UIColor.gray
        }
    }
}

extension SignUpViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let password = passwordTextField.text,
            let emailAddress = emailAddressTextField.text {
            switch textField.tag {
            case 2: let flagEmail = Validation.isValidEmail(email: emailAddress)
            if flagEmail == false {
                showAlertViewController( message: Message.inValidEmail.message)
                }
            case 3: let flagPassword  = Validation.isValidPassword(password: password)
            if flagPassword == false {
                showAlertViewController( message: Message.inValidPassword.message)
                }
            case 4: if confirmPasswordTextField.text != password {
                showAlertViewController(title: "", message: Message.passwordMatch.message)
                }
            // TODO handle emailField
            default: print("hlo")
            }
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard firstNameTextField.text?.isEmpty == true || lastNameTextField.text?.isEmpty == true || emailAddressTextField.text?.isEmpty == true || passwordTextField.text?.isEmpty == true || confirmPasswordTextField.text?.isEmpty == true
            else {
                toggleSignUpButton(enabled: true)
                
                return true
        }
        toggleSignUpButton(enabled: false)
        
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField.tag {
        case 0: lastNameTextField.becomeFirstResponder()
        case 1: emailAddressTextField.becomeFirstResponder()
        case 2: passwordTextField.becomeFirstResponder()
        case 3: confirmPasswordTextField.becomeFirstResponder()
        case 4: textField.resignFirstResponder()
        signUpButtonTapped(signUpButton)
        default: print("")
        }
        
        return true
    }
}




