//
//  UserWorkers.swift
//  GetTwitter
//
//  Created by Duy Nguyen on 7/8/17.
//  Copyright © 2017 Duy Nguyen. All rights reserved.
//

import Foundation

class UserWorkers {
    
    static var currentUser: User?
    
    class func verifyCredentials() {
        
        GetTwitterClient.instance.request(method: .GET, urlString: TwitterEndpoints.UserCredentials, parameters: nil) { (response) in
            
            switch response {
            case .success(let data):
                UserWorkers.currentUser = User(from: data)
                break
                
            default:
                break
            }
        }
    }
    
}
