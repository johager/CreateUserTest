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
    
    // MARK: - Actions
    
    @objc func createUserButtonTapped() {
        guard let alert = Validator.alertFor(username: usernameTextField?.text, passwd1: passwd1TextField?.text, passwd2: passwd2TextField?.text, useGoodEmailCheck: useGoodEmailCheck) else { return }
        
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
