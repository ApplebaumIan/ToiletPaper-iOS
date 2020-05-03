//
//  StoryVC.swift
//  FInalProject
//
//  Created by Likhon Gomes on 4/19/20.
//  Copyright © 2020 Likhon Gomes. All rights reserved.
//

import UIKit
import Firebase

class StoryVC: BaseViewController, UIGestureRecognizerDelegate {

    let storyNameLabel = UILabel()
    let storyBodyTextView = UITextView()
    let loveButton = UIButton()
    let paperView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        backButtonSetup()
        storyNameSetup()
        paperViewSetup()
        storyBodyTextViewSetup()
        loveButtonSetup()
        
//        let gesture = UIPanGestureRecognizer(target: self, action: Selector("wasDragged:"))
//        paperView.addGestureRecognizer(gesture)
//        paperView.isUserInteractionEnabled = true
//        gesture.delegate = self
        
    }
    
    func wasDragged(gestureRecognizer: UIPanGestureRecognizer) {
        if gestureRecognizer.state == UIGestureRecognizer.State.began || gestureRecognizer.state == UIGestureRecognizer.State.changed {
            let translation = gestureRecognizer.translation(in: self.view)
            print(gestureRecognizer.view!.center.y)
            if(gestureRecognizer.view!.center.y < 555) {
                gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x, y: gestureRecognizer.view!.center.y + translation.y)
            }else {
                gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x, y: 554)
            }

            gestureRecognizer.setTranslation(CGPoint(x: 0,y: 0), in: self.view)
        }

    }
    
    func paperViewSetup(){
        view.addSubview(paperView)
        paperView.translatesAutoresizingMaskIntoConstraints = false
        paperView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        paperView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5).isActive = true
        paperView.heightAnchor.constraint(equalToConstant: view.frame.size.width*1.25).isActive = true
        paperView.topAnchor.constraint(equalTo: storyNameLabel.bottomAnchor, constant: 5).isActive = true
        paperView.backgroundColor = .white

        paperView.layer.shadowColor = UIColor.black.cgColor
        paperView.layer.shadowOpacity = 0.5
        paperView.layer.shadowOffset = .zero
        paperView.layer.shadowRadius = 10
//        paperView.layer.shadowPath = UIBezierPath(rect: paperView.bounds).cgPath
//        paperView.layer.shouldRasterize = true
//        paperView.layer.rasterizationScale = UIScreen.main.scale
        //paperView.layer.borderColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    }

    func loveButtonSetup(){
        view.addSubview(loveButton)
        loveButton.translatesAutoresizingMaskIntoConstraints = false
        loveButton.heightAnchor.constraint(equalToConstant: 25).isActive = true
        loveButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
        loveButton.centerYAnchor.constraint(equalTo: backButton.centerYAnchor).isActive = true
        loveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        loveButton.setImage(#imageLiteral(resourceName: "loveHollow"), for: .normal)
        loveButton.setImage(#imageLiteral(resourceName: "lovefull"), for: .selected)
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
        paperView.addSubview(storyBodyTextView)
        storyBodyTextView.translatesAutoresizingMaskIntoConstraints = false
        storyBodyTextView.leadingAnchor.constraint(equalTo: paperView.leadingAnchor, constant: 10).isActive = true
        storyBodyTextView.bottomAnchor.constraint(equalTo: paperView.bottomAnchor, constant: -10).isActive = true
        storyBodyTextView.topAnchor.constraint(equalTo: paperView.topAnchor, constant: 10).isActive = true
        storyBodyTextView.trailingAnchor.constraint(equalTo: paperView.trailingAnchor,constant: -10).isActive = true
        storyBodyTextView.font = UIFont.systemFont(ofSize: 20)
        storyBodyTextView.isSelectable = false
        storyBodyTextView.isEditable = false
        storyBodyTextView.sizeToFit()
    }

}

