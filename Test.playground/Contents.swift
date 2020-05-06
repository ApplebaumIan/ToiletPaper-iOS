import UIKit

var str = "Hello, playground"


func getNewsData(){
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
            //print(json)
            
            var n = 0
            for dictionary in json as! [String:AnyObject] {
                //dictionary.value
                //print(">>>>> \(dictionary.1)")
                if n == 2 {
                    let d2 = dictionary.1
                    print(d2)
                }
                //print(type(of: dictionary.1))
                n += 1
            }
            
        } catch let jsonError {
            print(jsonError)
        }
        
    })
    task.resume()
}

getNewsData()
