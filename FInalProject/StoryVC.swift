//
//  StoryVC.swift
//  FInalProject
//
//  Created by Likhon Gomes on 4/19/20.
//  Copyright © 2020 Likhon Gomes. All rights reserved.
//

import UIKit
import Firebase

class StoryVC: UIViewController {

    let storyNameLabel = UILabel()
    let storyBodyTextView = UITextView()
    let backButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        backButtonSetup()
        storyNameSetup()
        storyBodyTextViewSetup()
        //pushDataToFirestore()
    }
    
    func pushDataToFirestore(){
        let citiesRef = db.collection("cities")

        
        citiesRef.document("BJ").setData([
            "name": "Beijing",
            "country": "China",
            "capital": true,
            "population": 21500000,
            "regions": ["jingjinji", "hebei"]
            ])
    }
    

    
    func storyNameSetup(){
        view.addSubview(storyNameLabel)
        storyNameLabel.translatesAutoresizingMaskIntoConstraints = false
        storyNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        storyNameLabel.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 5).isActive = true
        storyNameLabel.font = UIFont.boldSystemFont(ofSize: 30)
    }
    
    func storyBodyTextViewSetup(){
        view.addSubview(storyBodyTextView)
        storyBodyTextView.translatesAutoresizingMaskIntoConstraints = false
        storyBodyTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        storyBodyTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        storyBodyTextView.topAnchor.constraint(equalTo: storyNameLabel.bottomAnchor, constant: 10).isActive = true
        storyBodyTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20).isActive = true
        storyBodyTextView.font = UIFont.systemFont(ofSize: 20)
        storyBodyTextView.isSelectable = false
        storyBodyTextView.isEditable = false
        //storyBodyTextView.textAlignment = .justified
        storyBodyTextView.sizeToFit()
    }
    
    func backButtonSetup(){
        view.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        backButton.setImage(#imageLiteral(resourceName: "back"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }

    @objc func backButtonTapped(){
        dismiss(animated: true, completion: nil)
    }
}

