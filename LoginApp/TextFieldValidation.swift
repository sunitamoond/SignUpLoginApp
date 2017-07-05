//
//  TextFieldValidation.swift
//  LoginApp
//
//  Created by Sunita Moond on 04/07/17.
//  Copyright © 2017 Sunita Moond. All rights reserved.
//

import Foundation
func isValidEmail(email: String) -> Bool {
    let REGEX: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
    return NSPredicate(format: "SELF MATCHES %@",REGEX).evaluate(with: email)
}

func isValidPassword(password: String) -> Bool {
    let REGEX: String = "((?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%]).{8,32})"
    return NSPredicate(format: "SELF MATCHES %@",REGEX).evaluate(with: password)
}



