//
//  StoryListView.swift
//  FInalProject
//
//  Created by Likhon Gomes on 4/19/20.
//  Copyright © 2020 Likhon Gomes. All rights reserved.
//

import UIKit
import FirebaseAuth

class StoryListVC: UIViewController {

    let storyTable = UITableView()
    let segmentedControl = UISegmentedControl()
    let logoutButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        storyTableSetup()
        readDataFromFirestore()
        logoutButtonSetup()
    }
    
    func logoutButtonSetup(){
        view.addSubview(logoutButton)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        logoutButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
        logoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        logoutButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        logoutButton.setImage(#imageLiteral(resourceName: "logout"), for: .normal)
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
    
    func segmentedControlSetup(){
        view.addSubview(segmentedControl)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        segmentedControl.widthAnchor.constraint(equalToConstant: 100).isActive = true
        segmentedControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
    
    func storyTableSetup(){
        view.addSubview(storyTable)
        storyTable.translatesAutoresizingMaskIntoConstraints = false
        storyTable.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        storyTable.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        storyTable.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        storyTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        storyTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        storyTable.delegate = self
        storyTable.dataSource = self
    }
    
    func readDataFromFirestore(){
        db.collection("users").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    guard let storyname = document.data()["storyname"] else {return}
                    guard let story = document.data()["story"] else {return}
                    let storyNode = Story(story: story as! String, storyname: storyname as! String)
                    stories.append(storyNode)
                    self.storyTable.reloadData()
                }
            }
        }
    }
    
}

extension StoryListVC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = storyTable.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = stories[indexPath.row].storyname as! String
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = StoryVC()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.storyNameLabel.text = stories[indexPath.row].storyname
        vc.storyBodyTextView.text = stories[indexPath.row].story
        present(vc, animated: true, completion: nil)
    }
    
}
