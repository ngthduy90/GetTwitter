//
//  Tweet.swift
//  GetTwitter
//
//  Created by Duy Nguyen on 7/3/17.
//  Copyright © 2017 Duy Nguyen. All rights reserved.
//

import Foundation
import SwiftyJSON

class Tweet {
    
    var id: String
    var text: String
    
    var retweetCount: Int
    var favoriteCount: Int
    
    var isFavorited: Bool
    var isRetweeted: Bool
    
    var user: User
    var retweet: Tweet?
    var createdAt: String
    
    init(from json: JSON) {
        
        id = json["id_str"].string ?? "-1"
        text = json["text"].string ?? ""
        createdAt = json["created_at"].string ?? ""
        
        retweetCount = json["retweet_count"].int ?? 0
        favoriteCount = json["favorite_count"].int ?? 0
        
        isFavorited = json["favorited"].bool ?? false
        isRetweeted = json["retweeted"].bool ?? false
        
        user = User(from: json["user"])
        
        if json["retweeted_status"].exists() {
            retweet = Tweet(from: json["retweeted_status"])
        }
    }
}
