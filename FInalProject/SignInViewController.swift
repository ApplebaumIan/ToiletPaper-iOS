//
//  SignInViewController.swift
//  FInalProject
//
//  Created by Likhon Gomes on 5/1/20.
//  Copyright © 2020 Likhon Gomes. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignInViewController: UIViewController {

    let emailTextField = UITextField()
    let passwordTextField = UITextField()
    let usernameTextField = UITextField()
    let signInButton = UIButton()
    let signUpButton = UIButton()
    let logoImage = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        view.backgroundColor = .white
        hideKeyboardWhenTappedAround()
        signUpButtonSetup()
        signInButtonSetup()
        passwordTextFieldSetup()
        emailTextFieldSetup()
        usernameTextFieldSetup()
        logoImageSetup()
    }
    
    func logoImageSetup(){
        view.addSubview(logoImage)
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        logoImage.heightAnchor.constraint(equalToConstant: 200).isActive = true
        logoImage.widthAnchor.constraint(equalToConstant: 200).isActive = true
        logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        logoImage.image = #imageLiteral(resourceName: "icon")
    }
    
    func usernameTextFieldSetup(){
        view.addSubview(usernameTextField)
        usernameTextField.translatesAutoresizingMaskIntoConstraints = false
        usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        usernameTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        usernameTextField.bottomAnchor.constraint(equalTo: emailTextField.topAnchor, constant: -10).isActive = true
        usernameTextField.backgroundColor = .white
        usernameTextField.placeholder = "Username"
        usernameTextField.layer.borderWidth = 1
        usernameTextField.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        usernameTextField.isHidden = true
        usernameTextField.layer.cornerRadius = 10
        usernameTextField.autocapitalizationType = .none
    }
    
    func emailTextFieldSetup(){
        view.addSubview(emailTextField)
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        emailTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        emailTextField.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -10).isActive = true
        emailTextField.placeholder = "Email"
        emailTextField.backgroundColor = .white
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        emailTextField.layer.cornerRadius = 10
        emailTextField.textContentType = .emailAddress
        emailTextField.autocapitalizationType = .none
    }
    
    func passwordTextFieldSetup(){
        view.addSubview(passwordTextField)
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        passwordTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        passwordTextField.bottomAnchor.constraint(equalTo: signInButton.topAnchor, constant: -20).isActive = true
        passwordTextField.backgroundColor = .white
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        passwordTextField.placeholder = "Password"
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.textContentType = .password
        passwordTextField.autocapitalizationType = .none
    }
 
    func signInButtonSetup(){
        view.addSubview(signInButton)
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        signInButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        signInButton.bottomAnchor.constraint(equalTo: signUpButton.topAnchor, constant: -80).isActive = true
        signInButton.backgroundColor = .black
        signInButton.setTitleColor(.white, for: .normal)
        signInButton.setTitle("Sign in", for: .normal)
        signInButton.layer.cornerRadius = 10
        signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
    }
    
    @objc func signInButtonTapped(){
        if signUpButton.isSelected == false {
            if emailTextField.text != "" && passwordTextField.text != "" {
                Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { [weak self] authResult, error in
                  guard let strongSelf = self else { return }
                    if error != nil {
                        let alertController = UIAlertController(title: "Sign in failed", message: error?.localizedDescription, preferredStyle: .alert)
                        //We add buttons to the alert controller by creating UIAlertActions:
                        let actionOk = UIAlertAction(title: "OK",
                            style: .default,
                            handler: nil)
                        alertController.addAction(actionOk)
                        self!.present(alertController, animated: true, completion: nil)
                    } else {
                        defaults.set(true, forKey: "tp_signedin")
                        let vc = StoryListVC()
                        vc.modalPresentationStyle = .fullScreen
                        vc.modalTransitionStyle = .crossDissolve
                        self!.present(vc, animated: true, completion: nil)
                    }
                }
            } else {
                if emailTextField.text == "" {
                    emailTextField.shake()
                    emailTextField.layer.borderWidth = 1
                    emailTextField.layer.borderColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
                }
                if passwordTextField.text == "" {
                    passwordTextField.shake()
                    passwordTextField.layer.borderWidth = 1
                    passwordTextField.layer.borderColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
                }
            }
        } else {
            if emailTextField.text != "" && passwordTextField.text != "" && usernameTextField.text != "" {
                ///Sign up new user on firebase
                Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { authResult, error in
                    if error != nil {
                        let alertController = UIAlertController(title: "Sign up failed", message: error?.localizedDescription, preferredStyle: .alert)
                        //We add buttons to the alert controller by creating UIAlertActions:
                        let actionOk = UIAlertAction(title: "OK",
                            style: .default,
                            handler: nil)
                        alertController.addAction(actionOk)
                        self.present(alertController, animated: true, completion: nil)
                    } else {
                        defaults.set(true, forKey: "tp_signedin")
                        let vc = StoryListVC()
                        vc.modalPresentationStyle = .fullScreen
                        vc.modalTransitionStyle = .crossDissolve
                        self.present(vc, animated: true, completion: nil)
                    }
                }
            } else {
                if emailTextField.text == "" {
                    emailTextField.shake()
                    emailTextField.layer.borderWidth = 1
                    emailTextField.layer.borderColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
                }
                if passwordTextField.text == "" {
                    passwordTextField.shake()
                    passwordTextField.layer.borderWidth = 1
                    passwordTextField.layer.borderColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
                }
                if usernameTextField.text == "" {
                    usernameTextField.shake()
                    usernameTextField.layer.borderWidth = 1
                    usernameTextField.layer.borderColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
                }
            }
        }
    }
    
    func signUpButtonSetup(){
        view.addSubview(signUpButton)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        signUpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        signUpButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        signUpButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        signUpButton.setTitleColor(.black, for: .normal)
        signUpButton.setTitle("Don't have an account?", for: .normal)
        signUpButton.setTitle("Already have an account?", for: .selected)
        signUpButton.layer.cornerRadius = 10
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
    }

    @objc func signUpButtonTapped(){
        if signUpButton.isSelected {
            signUpButton.isSelected = false
            signInButton.setTitle("Sign in", for: .normal)
            usernameTextField.isHidden = true
        } else {
            signUpButton.isSelected = true
            signInButton.setTitle("Sign up", for: .normal)
            usernameTextField.isHidden = false
        }
    }
    

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
}
