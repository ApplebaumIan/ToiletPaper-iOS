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
    let settingsButton = UIButton()
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        storyTableSetup()
        readDataFromFirestore()
        settingsButtonSetup()
        labelSetup()
    }
    

    
    func labelSetup(){
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        label.bottomAnchor.constraint(equalTo: storyTable.topAnchor, constant: -10).isActive = true
        label.trailingAnchor.constraint(equalTo: settingsButton.leadingAnchor, constant: -5).isActive = true
        label.text = "toiletpaper."
        label.font = UIFont.boldSystemFont(ofSize: 35)
    }
    
    func settingsButtonSetup(){
        view.addSubview(settingsButton)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        settingsButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
        settingsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        settingsButton.bottomAnchor.constraint(equalTo: storyTable.topAnchor, constant: -12).isActive = true
        settingsButton.setImage(#imageLiteral(resourceName: "setings"), for: .normal)
        settingsButton.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
    }
    
    @objc func settingsButtonTapped(){
        let vc = SettingsViewController()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
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
        storyTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70).isActive = true
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
        self.storyTable.deselectRow(at: indexPath, animated: true)
        let vc = StoryVC()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        vc.storyNameLabel.text = stories[indexPath.row].storyname
        vc.storyBodyTextView.text = stories[indexPath.row].story
        present(vc, animated: true, completion: nil)
    }
    
}
