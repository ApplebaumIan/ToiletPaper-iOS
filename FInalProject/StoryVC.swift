//
//  StoryVC.swift
//  FInalProject
//
//  Created by Likhon Gomes on 4/19/20.
//  Copyright © 2020 Likhon Gomes. All rights reserved.
//

import UIKit
import Firebase

class StoryVC: BaseViewController {

    let storyNameLabel = UILabel()
    let storyBodyTextView = UITextView()
    let loveButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        backButtonSetup()
        storyNameSetup()
        storyBodyTextViewSetup()
        loveButtonSetup()
    }

    func loveButtonSetup(){
        view.addSubview(loveButton)
        loveButton.translatesAutoresizingMaskIntoConstraints = false
        loveButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        loveButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
        loveButton.centerYAnchor.constraint(equalTo: backButton.centerYAnchor).isActive = true
        loveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        loveButton.setImage(#imageLiteral(resourceName: "loveHollow"), for: .normal)
        loveButton.setImage(#imageLiteral(resourceName: "loveFull"), for: .selected)
        loveButton.addTarget(self, action: #selector(loveButtonTapped), for: .touchUpInside)
    }
    
    @objc func loveButtonTapped(){
        if loveButton.isSelected {
            loveButton.isSelected = false
        } else {
            loveButton.isSelected = true
        }
    }
    
    func updateDataToFirestore(){
        
    }
    
    
    func storyNameSetup(){
        view.addSubview(storyNameLabel)
        storyNameLabel.translatesAutoresizingMaskIntoConstraints = false
        storyNameLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 20).isActive = true
        storyNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
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

}

