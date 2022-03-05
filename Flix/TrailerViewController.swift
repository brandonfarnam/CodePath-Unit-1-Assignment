//
//  TrailerViewController.swift
//  Flix
//
//  Created by Nguyen, Khang on 3/3/22.
//

import UIKit
import WebKit
class TrailerViewController: UIViewController, WKNavigationDelegate {
    
    @IBOutlet weak var trailerWebView: WKWebView!
    var key: Any!
    var movies = [[String:Any]]()

   
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(key.unsafelyUnwrapped)/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US")!

        
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)

        
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                self.movies = dataDictionary["results"] as! [[String:Any]] // casting as an array of dictionaries
                
                let videoKey = self.movies[0]["key"] as! String
                let urlForVideo = URL(string: "https://www.youtube.com/watch?v=\(videoKey)")
                let request = URLRequest(url: urlForVideo!)
                self.trailerWebView.load(request)
            }
        }
        task.resume()
//
//
//        let trailerUrl = URL(string: "https://www.youtube.com/watch?v=\(key.unsafelyUnwrapped)")
//        let request = URLRequest(url: trailerUrl!)
//        trailerWebView.load(request)

        // Do any additional setup after loading the view.
    }
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
