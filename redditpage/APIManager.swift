//
//  APIManager.swift
//  redditpage
//
//  Created by fm on 2018-08-09.
//  Copyright © 2018 f. All rights reserved.
//

import Foundation
import Alamofire

class APIManager {
    
    let theRedditPageUrl = "https://www.reddit.com/.json"
    
    func getRedditPage( completionHandler: ( ( [ [String : Any] ] ) -> Void )? = nil ) {
        
        Alamofire.request(theRedditPageUrl).responseJSON { response in
            
            if let json = response.result.value, let jsonDict = json as? [String : Any],
                let theData = jsonDict["data"] as? [String:Any],
                let theChildren = theData["children"] as? [ [String:Any] ] {
                    
                    if let theCompletionHandler = completionHandler {
                        theCompletionHandler(theChildren)
                    }
            }
        }
    }
    
    
    
    
}
