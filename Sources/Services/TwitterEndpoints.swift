//
//  TwitterEndpoints.swift
//  GetTwitter
//
//  Created by Duy Nguyen on 7/3/17.
//  Copyright © 2017 Duy Nguyen. All rights reserved.
//

import Foundation

struct TwitterEndpoints {
    
    static let HomeTimeline = "1.1/statuses/home_timeline.json"
    
    static let UpdateTweet = "1.1/statuses/update.json"
    
    static let CreateFavorite = "1.1/favorites/create.json"
    
    static let Unfavorite = "1.1/favorites/destroy.json"
    
    static let UserTimeLine = "1.1/statuses/user_timeline.json"
    
}
