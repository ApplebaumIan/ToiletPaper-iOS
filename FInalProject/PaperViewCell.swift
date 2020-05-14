//
//  PaperViewCell.swift
//  FInalProject
//
//  Created by Likhon Gomes on 5/5/20.
//  Copyright © 2020 Likhon Gomes. All rights reserved.
//

import Foundation
import UIKit

class PaperViewCell: UICollectionViewCell, UITextViewDelegate {
    
    let paperView = UIView()
    let headlineTextView = UITextView()
    let newsBody = UITextView()
    
    
    
    func paperViewSetup(){
        addSubview(paperView)
        paperView.translatesAutoresizingMaskIntoConstraints = false
        
        
        paperView.heightAnchor.constraint(equalToConstant: frame.size.width-10).isActive = true
        paperView.widthAnchor.constraint(equalToConstant: frame.size.width-40).isActive = true
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
        headlineTextView.topAnchor.constraint(equalTo: paperView.topAnchor, constant: 30).isActive = true
        headlineTextView.leadingAnchor.constraint(equalTo: paperView.leadingAnchor,constant: 20).isActive = true
        headlineTextView.trailingAnchor.constraint(equalTo: paperView.trailingAnchor, constant: -10).isActive = true
        headlineTextView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        headlineTextView.sizeToFit()
        headlineTextView.text = "Headline"
        headlineTextView.textAlignment = .left
        headlineTextView.font = UIFont.boldSystemFont(ofSize: 25)
        headlineTextView.textColor = .black
        headlineTextView.backgroundColor = .clear
        headlineTextView.isScrollEnabled = false
    }
    
    func adjustUITextViewHeight(arg : UITextView)
    {
        arg.translatesAutoresizingMaskIntoConstraints = true
        arg.sizeToFit()
        arg.isScrollEnabled = false
    }
    
    func newsBodySetup(){
        paperView.addSubview(newsBody)
        newsBody.translatesAutoresizingMaskIntoConstraints = false
        [
        newsBody.topAnchor.constraint(equalTo: headlineTextView.bottomAnchor, constant: 10),
        newsBody.leadingAnchor.constraint(equalTo: paperView.leadingAnchor,constant: 20),
        newsBody.trailingAnchor.constraint(equalTo: paperView.trailingAnchor, constant: -10),
        newsBody.bottomAnchor.constraint(equalTo: paperView.bottomAnchor, constant: -10),
            ].forEach{ $0.isActive = true }
        newsBody.textAlignment = .left
        newsBody.sizeToFit()
        newsBody.text = "The quick brown fox jumps over the lazy dog"
        newsBody.font = UIFont.systemFont(ofSize: 18)
        newsBody.backgroundColor = .clear
        newsBody.textColor = .black
        newsBody.delegate = self
        newsBody.isEditable = false
        newsBody.isSelectable = false
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
