//
//  Validator.swift
//  CreateUserTest
//
//  Created by James Hager on 6/22/22.
//

import UIKit

enum Validator {
    
    static func usernameIsOK(_ username: String, useGoodEmailCheck: Bool) -> Bool {
        if useGoodEmailCheck {
            let regex = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
            let test = NSPredicate(format:"SELF MATCHES %@", regex)
            return test.evaluate(with: username)
            
        } else {
            return username.contains("@") && username.hasSuffix(".com")
        }
    }
    
    static func passwdIsOK(_ passwd: String) -> Bool {
        if passwd.count < 6 {
            return false
        }
        
        let capitalLetterRegEx = ".*[A-Z]+.*"
        let testCap = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
        guard testCap.evaluate(with: passwd) else { return false }
        
        let numberRegEx = ".*[0-9]+.*[0-9]+.*"
        let testNum = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        guard testNum.evaluate(with: passwd) else { return false }
        
        let specialCharacterRegEx = ".*[!@#%^&*()_]+.*"
        let testSpec = NSPredicate(format:"SELF MATCHES %@", specialCharacterRegEx)
        guard testSpec.evaluate(with: passwd) else { return false }
        
        return true
    }
    
    static func alertFor(username: String?, passwd1: String?, passwd2: String?, useGoodEmailCheck: Bool) -> UIAlertController? {
        guard let username = username,
              let passwd1 = passwd1,
              let passwd2 = passwd2,
              username.count > 0,
              passwd1.count > 0,
              passwd2.count > 0
        else { return nil }
        
        var messageText = ""
        
        if !usernameIsOK(username, useGoodEmailCheck: useGoodEmailCheck) {
            messageText = "Your username must be a valid email address (have an '@' in the middle and ends with '.com'."
        }
        
        if passwd1 != passwd2 {
            if messageText.count > 0 {
                messageText += "\n\n"
            }
            messageText += "The two passwords do not match."
        }
        
        if !passwdIsOK(passwd1) {
            if messageText.count > 0 {
                messageText += "\n\n"
            }
            messageText += "The password is not valid. It must be at least 6 characters long and have at least 1 uppercase character, 1 special character, and at least 2 numbers."
        }
        
        let title: String
        if messageText.count == 0 {
            title = "Success"
            messageText = "This is a valid user name and password."
        } else {
            title = "Error"
        }
        
        let alert = UIAlertController(title: title, message: messageText, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        
        return alert
    }
}
