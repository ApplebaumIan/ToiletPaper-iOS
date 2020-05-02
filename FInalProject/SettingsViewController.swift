//
//  SettingsViewController.swift
//  FInalProject
//
//  Created by Likhon Gomes on 5/1/20.
//  Copyright © 2020 Likhon Gomes. All rights reserved.
//

import UIKit
import FirebaseAuth

class SettingsViewController: BaseViewController {

    let logoutButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logoutButtonSetup()
    }
    
    func logoutButtonSetup(){
        view.addSubview(logoutButton)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        logoutButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        logoutButton.backgroundColor = .black
        logoutButton.setTitleColor(.white, for: .normal)
        logoutButton.setTitle("Log out", for: .normal)
        logoutButton.layer.cornerRadius = 20
        logoutButton.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
    }

    @objc func logoutButtonTapped(){
        try! Auth.auth().signOut()
        defaults.set(false, forKey: "tp_signedin")
        let vc = SignInViewController()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }

}
