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
    
    fileprivate func showAlertViewController(title: String, message: String) {
        let alertController = UIAlertController(title: title,  message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title:"OK",style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true)
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        
        guard let firstName = firstNameTextField.text,
            let lastName = lastNameTextField.text,
            let emailAddress = emailAddressTextField.text,
            let password = passwordTextField.text,
            let confirmPassword = confirmPasswordTextField.text else {
                showAlertViewController(title: "Invalid", message: "fill All the fields")
                return
        }
        let flagEmail = isValidEmail(email: emailAddress)
        if flagEmail == false {
            showAlertViewController(title: "Invalid", message: "Enter Valid Email")
        }
        let flagPassword  = isValidPassword(password: password)
        if flagPassword == false {
            showAlertViewController(title: "Invalid", message: "Enter Valid Password that contain 1 Upper Case 1 LowerCase  1 digit and 1 special charater and length should be 8-32 charater")
        }
        if confirmPassword != password {
            showAlertViewController(title: "", message: "Password and ConfirmPassword Should be Match")
        }
        if (UserDefaults.standard.object(forKey: emailAddress) as? [String: String]) != nil {
            showAlertViewController(title: "Invalid", message: "Duplicate email address")
            
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
            case 2: let flagEmail = isValidEmail(email: emailAddress)
            if flagEmail == false {
                showAlertViewController(title: "Invalid", message: "Enter Valid Email")
                }
            case 3: let flagPassword  = isValidPassword(password: password)
            if flagPassword == false {
                showAlertViewController(title: "Invalid", message: "Enter Valid Password that contain 1 Upper Case 1 LowerCase  1 digit and 1 special charater and length should be 8-32 charater")
                }
            case 4: if confirmPasswordTextField.text != password {
                showAlertViewController(title: "", message: "Password and ConfirmPassword Should be Match")
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




