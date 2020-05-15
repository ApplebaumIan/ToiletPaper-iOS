//
//  BaseViewController.swift
//  FInalProject
//
//  Created by Likhon Gomes on 5/1/20.
//  Copyright © 2020 Likhon Gomes. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    let backButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButtonSetup()
        view.backgroundColor = .white
    }
    

    func backButtonSetup(){
        view.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        backButton.setImage(#imageLiteral(resourceName: "arrows"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }

    @objc func backButtonTapped(){
        dismiss(animated: true, completion: nil)
    }
}
