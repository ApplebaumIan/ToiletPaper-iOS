//
//  Article.swift
//  FInalProject
//
//  Created by Likhon Gomes on 5/5/20.
//  Copyright © 2020 Likhon Gomes. All rights reserved.
//

import Foundation

class News: Decodable {
    let status:String?
    let totalResults:Int?
    let articles: [Article]
}

class Article: Decodable {
    
    let source:Source?
    let author:String?
    let title:String?
    let description:String?
    let url:String?
    let urlToImage:String?
    let publishedAt:String?
    let content:String?


}

class Source: Decodable {
    let id:String?
    let name:String?
}


