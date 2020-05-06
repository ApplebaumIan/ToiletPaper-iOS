//
//  PaperViewCell.swift
//  FInalProject
//
//  Created by Likhon Gomes on 5/5/20.
//  Copyright © 2020 Likhon Gomes. All rights reserved.
//

import Foundation
import UIKit

class PaperViewCell: UICollectionViewCell {
    
    let paperView = UIView()
    let headlineTextView = UITextView()
    let newsBody = UITextView()
    
    
    
    func paperViewSetup(){
        addSubview(paperView)
        paperView.translatesAutoresizingMaskIntoConstraints = false
        
        
        paperView.heightAnchor.constraint(equalToConstant: frame.size.width-10).isActive = true
        paperView.widthAnchor.constraint(equalToConstant: frame.size.width-20).isActive = true
        paperView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        paperView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        paperView.layer.cornerRadius = 30
        paperView.backgroundColor = .white
        paperView.layer.shadowColor = UIColor.black.cgColor
        paperView.layer.shadowOpacity = 0.5
        paperView.layer.shadowOffset = .zero
        paperView.layer.shadowRadius = 10
    }
    
    
    
    func headlineTextViewSetup(){
        paperView.addSubview(headlineTextView)
        headlineTextView.translatesAutoresizingMaskIntoConstraints = false
        headlineTextView.topAnchor.constraint(equalTo: paperView.topAnchor, constant: 10).isActive = true
        headlineTextView.leadingAnchor.constraint(equalTo: paperView.leadingAnchor,constant: 10).isActive = true
        headlineTextView.trailingAnchor.constraint(equalTo: paperView.trailingAnchor, constant: -10).isActive = true
        headlineTextView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        headlineTextView.text = "Headline"
        headlineTextView.textAlignment = .center
        headlineTextView.font = UIFont.boldSystemFont(ofSize: 30)
        headlineTextView.textColor = .black
        headlineTextView.backgroundColor = .clear
        headlineTextView.isScrollEnabled = false
    }
    
    func newsBodySetup(){
        paperView.addSubview(newsBody)
        newsBody.translatesAutoresizingMaskIntoConstraints = false
        newsBody.topAnchor.constraint(equalTo: headlineTextView.bottomAnchor, constant: 10).isActive = true
        newsBody.leadingAnchor.constraint(equalTo: paperView.leadingAnchor,constant: 10).isActive = true
        newsBody.trailingAnchor.constraint(equalTo: paperView.trailingAnchor, constant: -10).isActive = true
        newsBody.bottomAnchor.constraint(equalTo: paperView.bottomAnchor, constant: -10).isActive = true
        newsBody.textAlignment = .center
        newsBody.text = "The quick brown fox jumps over the lazy dog"
        newsBody.contentMode = .center
        newsBody.font = UIFont.systemFont(ofSize: 24)
        newsBody.backgroundColor = .clear
        newsBody.textColor = .black
        newsBody.isScrollEnabled = false
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        paperViewSetup()
        headlineTextViewSetup()
        newsBodySetup()
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
