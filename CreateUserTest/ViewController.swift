//
//  ViewController.swift
//  CreateUserTest
//
//  Created by James Hager on 6/20/22.
//

import UIKit

class ViewController: UIViewController {
    
    let useGoodEmailCheck = false
    
    // MARK: - Views
    
    var usernameTextField: UITextField!
    var passwd1TextField: UITextField!
    var passwd2TextField: UITextField!
    var createUserButton: UIButton!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }

    // MARK: - Set Up
    
    func setUpView() {
        
        let safeArea = view.safeAreaLayoutGuide
        
        usernameTextField = textField(placeholder: "username (email)")
        view.addSubview(usernameTextField)
        usernameTextField.pin(top: nil, trailing: safeArea.trailingAnchor, bottom: nil, leading: safeArea.leadingAnchor, margin: [0, 16, 0, 16])
        let usernameTopConstraint = NSLayoutConstraint(item: usernameTextField!, attribute: .top, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 0.3, constant: 0)
        view.addConstraint(usernameTopConstraint)
        
        passwd1TextField = textField(placeholder: "password")
        view.addSubview(passwd1TextField)
        passwd1TextField.pin(top: usernameTextField.bottomAnchor, trailing: safeArea.trailingAnchor, bottom: nil, leading: safeArea.leadingAnchor, margin: [16, 16, 0, 16])
        
        passwd1TextField.isSecureTextEntry = true
        
        passwd2TextField = textField(placeholder: "password repeated")
        view.addSubview(passwd2TextField)
        passwd2TextField.pin(top: passwd1TextField.bottomAnchor, trailing: safeArea.trailingAnchor, bottom: nil, leading: safeArea.leadingAnchor, margin: [16, 16, 0, 16])
        
        passwd2TextField.isSecureTextEntry = true
        
        createUserButton = UIButton()
        view.addSubview(createUserButton)
        createUserButton.pin(top: passwd2TextField.bottomAnchor, trailing: nil, bottom: nil, leading: nil, margin: [32, 0, 0, 0])
        createUserButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        createUserButton.setTitle("Create User", for: .normal)
        createUserButton.setTitleColor(.systemBlue, for: .normal)
        createUserButton.setTitleColor(.gray, for: .disabled)
        createUserButton.isEnabled = false
        createUserButton.addTarget(self, action: #selector(createUserButtonTapped), for: .touchUpInside)
    }
    
    func textField(placeholder: String) -> UITextField {
        let textField = UITextField()
        textField.font = UIFont.preferredFont(forTextStyle: .body)
        textField.adjustsFontForContentSizeCategory = true
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.borderStyle = .roundedRect
        textField.placeholder = placeholder
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return textField
    }
    
    // MARK: - Methods
    
    func usernameIsOK(_ username: String, useGoodEmailCheck: Bool) -> Bool {
        if useGoodEmailCheck {
            let regex = "[A-Z0-9a-z.-_]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
            let test = NSPredicate(format:"SELF MATCHES %@", regex)
            return test.evaluate(with: username)
            
        } else {
            return username.contains("@") && username.hasSuffix(".com")
        }
    }
    
    func passwdIsOK(_ passwd: String) -> Bool {
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
    
    // MARK: - Actions
    
    @objc func createUserButtonTapped() {
        guard let username = usernameTextField?.text,
              let passwd1 = passwd1TextField?.text,
              let passwd2 = passwd2TextField?.text,
              passwd1.count > 0,
              passwd2.count > 0
        else { return }
        
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
        
        present(alert, animated: true, completion: nil)
    }
    
    @objc func textFieldDidChange() {
        guard let username = usernameTextField?.text,
              let passwd1 = passwd1TextField?.text,
              let passwd2 = passwd2TextField?.text,
              username.count > 0,
              passwd1.count > 0,
              passwd2.count > 0
        else {
            createUserButton.isEnabled = false
            return
        }
        createUserButton.isEnabled = true
    }
}
