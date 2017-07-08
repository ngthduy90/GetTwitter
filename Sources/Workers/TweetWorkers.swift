//
//  TweetWorkers.swift
//  GetTwitter
//
//  Created by Duy Nguyen on 7/3/17.
//  Copyright © 2017 Duy Nguyen. All rights reserved.
//

import Foundation

class TweetWorkers {
    
    class func fetchTwentyTweets(completion: @escaping ([Tweet]?) -> Void) {
        
        GetTwitterClient
            .instance
            .request(
                method: .GET,
                urlString: TwitterEndpoints.HomeTimeline,
                parameters: ["count": 20]) { (reponse) in
                    switch reponse {
                        
                    case .success(let result):
                        let tweets = result.arrayValue.map { Tweet(from: $0) }
                        completion(tweets)
                        break
                        
                    default:
                        completion(nil)
                        break
                    }
        }
    }
    
    class func postNewTweet(_ content: String, completion: @escaping (Tweet?) -> Void) {
        
        GetTwitterClient.instance.post(urlString: TwitterEndpoints.UpdateTweet,
                                       parameters: ["status": content]) { response in
            switch response {
            case .success(let result):
                completion(Tweet(from: result))
                break
                
            default:
                completion(nil)
                break
                
            }
        }
    }
    
}
