//
//  User.swift
//  GetTwitter
//
//  Created by Duy Nguyen on 7/3/17.
//  Copyright © 2017 Duy Nguyen. All rights reserved.
//

import Foundation
import SwiftyJSON

class User {
    
    var id: String
    var displayName: String
    var screenName: String
    
    var profileImageUrl: String
    var isProtected: Bool
    var isVerified: Bool
    
    init(from json: JSON) {
        
        id = json["id_str"].string ?? "-1"
        
        displayName = json["name"].string ?? ""
        screenName = json["screen_name"].string ?? ""
        profileImageUrl = json["profile_image_url_https"].string ?? ""
        
        isProtected = json["protected"].bool ?? false
        isVerified = json["verified"].bool ?? false

    }
}
