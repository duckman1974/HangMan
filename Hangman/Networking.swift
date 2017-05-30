//
//  Networking.swift
//  Hangman
//
//  Created by Kevin Reese on 5/15/17.
//  Copyright © 2017 Kevin Reese. All rights reserved.
//

import Foundation


class Networking: NSObject {
    
    var session = URLSession.shared
    var appDelegate: AppDelegate!
   
    
    func wordRetrieve(playLevel: String, completionHandler: @escaping(_ success: Bool, _ gameWord: String, _ error: String?) -> Void) {
       
        let urlString = Constants.Words.baseURL + Constants.Words.id + Constants.Words.len + playLevel
        //print(urlString)
        let request = NSMutableURLRequest(url: URL(string: urlString)!)
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            
            guard (error == nil) else {
                completionHandler(false, "", error as? String)
                return
            }
            
            guard let data = data else {
                completionHandler(false, "", error as? String)
                return
            }
 
            let gameWord = (NSString(data: data, encoding: String.Encoding.utf8.rawValue) as Any)
            completionHandler(true, gameWord as! String, nil)
        }
        
        task.resume()
    }
    
    
    class func sharedInstance() -> Networking {
        struct Singleton {
            static var sharedInstance = Networking()
        }
        return Singleton.sharedInstance
    }
    
    
}
