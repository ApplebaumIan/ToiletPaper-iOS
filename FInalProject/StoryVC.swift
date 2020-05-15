//
//  StoryVC.swift
//  FInalProject
//
//  Created by Likhon Gomes on 4/19/20.
//  Copyright © 2020 Likhon Gomes. All rights reserved.
//

import UIKit
import Firebase

class StoryVC: BaseViewController, UIGestureRecognizerDelegate, UITextViewDelegate, UIScrollViewDelegate {

    let storyNameLabel = UILabel()
    let storyBodyTextView = UITextView()
    let loveButton = UIButton()
    let paperView = UIView()
    let scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        backButtonSetup()
        storyNameSetup()
        scrollViewSetup()
        //paperViewSetup()
        storyBodyTextViewSetup()
        loveButtonSetup()
        
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
    
    func scrollViewSetup() {
        let actualScrollView = UIScrollView()
        view.addSubview(actualScrollView)
        actualScrollView.translatesAutoresizingMaskIntoConstraints = false
        actualScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        actualScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        actualScrollView.topAnchor.constraint(equalTo: storyNameLabel.bottomAnchor, constant: 10).isActive = true
        actualScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        actualScrollView.delegate = self
        actualScrollView.backgroundColor = .blue
        actualScrollView.isScrollEnabled = true
        
        //scrollView.frame = CGRect(x: 0, y: 0, width: 100, height: 2000)
//        actualScrollView.addSubview(scrollView)
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        scrollView.leadingAnchor.constraint(equalTo: actualScrollView.leadingAnchor).isActive = true
//        scrollView.topAnchor.constraint(equalTo: actualScrollView.topAnchor).isActive = true
//        scrollView.bottomAnchor.constraint(equalTo: actualScrollView.bottomAnchor).isActive = true
//        scrollView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
//        scrollView.isUserInteractionEnabled = true
//        scrollView.backgroundColor = .black
        
        
        view.addSubview(paperView)
        paperView.translatesAutoresizingMaskIntoConstraints = false
        [
        paperView.topAnchor.constraint(equalTo: storyNameLabel.bottomAnchor, constant: 40),
        paperView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
        paperView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        paperView.heightAnchor.constraint(equalToConstant: 1000),
            ].forEach{ $0.isActive = true }
        paperView.backgroundColor = .white

        paperView.layer.shadowColor = UIColor.black.cgColor
        paperView.layer.shadowOpacity = 0.5
        paperView.layer.shadowOffset = .zero
        paperView.layer.shadowRadius = 10
    }
    
    func paperViewSetup(){
        view.addSubview(paperView)
        paperView.translatesAutoresizingMaskIntoConstraints = false
        
        [
        paperView.topAnchor.constraint(equalTo: storyNameLabel.bottomAnchor, constant: 40),
        paperView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
        paperView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        paperView.heightAnchor.constraint(equalToConstant: view.frame.size.width*1.25),
            ].forEach{ $0.isActive = true }
        paperView.backgroundColor = .white

        paperView.layer.shadowColor = UIColor.black.cgColor
        paperView.layer.shadowOpacity = 0.5
        paperView.layer.shadowOffset = .zero
        paperView.layer.shadowRadius = 10
    }
    
    func textViewDidChange(_ textView: UITextView) {
        print("Text view changed")
        let size = CGSize(width: view.frame.width - 40, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        paperView.constraints.forEach { (constraint) in
            if constraint.firstAttribute == .height {
                constraint.constant = estimatedSize.height+view.frame.size.width*1.25
            }
        }
    }

    func loveButtonSetup(){
        view.addSubview(loveButton)
        loveButton.translatesAutoresizingMaskIntoConstraints = false
        loveButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        loveButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
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
        view.endEditing(true)
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
        [
        storyBodyTextView.topAnchor.constraint(equalTo: paperView.topAnchor, constant: 20),
        storyBodyTextView.leadingAnchor.constraint(equalTo: paperView.leadingAnchor,constant: 20),
        storyBodyTextView.trailingAnchor.constraint(equalTo: paperView.trailingAnchor, constant: -20),
        storyBodyTextView.bottomAnchor.constraint(equalTo: paperView.bottomAnchor, constant: -20),
            ].forEach{ $0.isActive = true }
        storyBodyTextView.font = UIFont.systemFont(ofSize: 20)
        //storyBodyTextView.isSelectable = false
        //storyBodyTextView.isEditable = false
        storyBodyTextView.isScrollEnabled = false
        storyBodyTextView.text = ""
        storyBodyTextView.delegate = self
        storyBodyTextView.backgroundColor = .red
//        storyBodyTextView.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    
    
    

}

