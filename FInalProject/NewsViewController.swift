//
//  NewsViewController.swift
//  FInalProject
//
//  Created by Likhon Gomes on 5/5/20.
//  Copyright © 2020 Likhon Gomes. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    

    var collectionview: UICollectionView!
    var cellId = "Cell"
    var newsData:News?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewSetup()
        fetchJSONNews()
        let timer = Timer.scheduledTimer(timeInterval: 0.1,target: self,selector: #selector(timedFunction),userInfo: nil ,repeats: true)
        
    }
    
    @objc func timedFunction(){
        print(newsData?.totalResults)
        collectionview.reloadData()
    }
    
    @objc func eventWith(timer: Timer!) {
        let info = timer.userInfo as Any
        collectionview.reloadData()
    }
    
    func fetchJSONNews() {
          
          DispatchQueue.main.async {
              let url = URL(string: "https://newsapi.org/v2/top-headlines?" +
              "country=us&" +
              "apiKey=2f319c181f714e5dae27dca004f64765")!
              let session = URLSession.shared
              session.dataTask(with: url)
              let task = session.dataTask(with: url, completionHandler: { data , response, error in
              // Check the response
                  if error != nil {
                      print(error)
                      return
                  }
                  do {
                      let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                      self.newsData = try! JSONDecoder().decode(News.self, from: data!)
                      print(">>>>>>>>> \(self.newsData?.status) \(self.newsData?.totalResults)")
                    DispatchQueue.main.async {
                        self.collectionview.reloadData()
                    }
                    
                  } catch let jsonError {
                      print(jsonError.localizedDescription)
                  }
              })
              task.resume()
          }
    
      }

    func collectionViewSetup(){
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.frame.width, height: view.frame.width)

        collectionview = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionview.dataSource = self
        collectionview.delegate = self
        collectionview.register(PaperViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionview.showsVerticalScrollIndicator = false
        collectionview.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        self.view.addSubview(collectionview)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if newsData == nil {
            return 10
        } else {
            return (newsData?.articles.count)!
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionview.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath as IndexPath) as! PaperViewCell
        cell.headlineTextView.text = newsData?.articles[indexPath.row].title ?? ""
        cell.newsBody.text = newsData?.articles[indexPath.row].description ?? ""
        cell.newsBody.sizeToFit()
        return cell
    }
    


}
