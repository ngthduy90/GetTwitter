//
//  YummyClient.swift
//  Yummy
//
//  Created by Duy Nguyen on 6/24/17.
//  Copyright © 2017 Duy Nguyen. All rights reserved.
//

import Foundation
import OAuthSwift
import SwiftyJSON

struct GetTwitterAPIConsole {
    var consumerKey = "cdgNdFWRl21StzmI247ZcbyoB"
    var consumerSecret = "KbsM3XkxrnOQkynyt1fTPZgnHWwxjsZg9zDcy7D32ceEhWkqtu"
    var oauthRequestTokenURL: String
    var oauthAuthorizeUrl: String
    var oauthAccessTokenUrl: String
    
    init(requestTokenUrl: String, authorizeUrl: String, accessTokenUrl: String) {
        oauthRequestTokenURL = requestTokenUrl
        oauthAuthorizeUrl = authorizeUrl
        oauthAccessTokenUrl = accessTokenUrl
    }
}

enum GetTwitterResponse {
    case success(JSON), error(Error), empty
}

class GetTwitterClient {
    
    static let instance = GetTwitterClient()
    
    let baseOAuthUrl = "https://api.twitter.com/oauth/"
    
    let oAuth: OAuth1Swift?
    let apiConsoleInfo: GetTwitterAPIConsole!
    
    var client: OAuthSwiftClient?
    
    private init() {
        apiConsoleInfo = GetTwitterAPIConsole(
            requestTokenUrl: "\(baseOAuthUrl)request_token",
            authorizeUrl: "\(baseOAuthUrl)authorize",
            accessTokenUrl: "\(baseOAuthUrl)access_token"
        )
        
        self.oAuth = OAuth1Swift(
            consumerKey: apiConsoleInfo.consumerKey,
            consumerSecret: apiConsoleInfo.consumerSecret,
            requestTokenUrl: apiConsoleInfo.oauthRequestTokenURL,
            authorizeUrl: apiConsoleInfo.oauthAuthorizeUrl,
            accessTokenUrl: apiConsoleInfo.oauthAccessTokenUrl
        )
        
        if isSignin() {
            let userDefault = UserDefaults.standard
            let token = userDefault.value(forKey: Constants.OAuth.Token) as! String
            let tokenSecret = userDefault.value(forKey: Constants.OAuth.TokenSecret) as! String
            
            client = OAuthSwiftClient(
                consumerKey: apiConsoleInfo.consumerKey,
                consumerSecret: apiConsoleInfo.consumerSecret,
                oauthToken: token,
                oauthTokenSecret: tokenSecret,
                version: .oauth1)
        }
    }
    
    func isSignin() -> Bool {
        
        return UserDefaults.standard.value(forKey: Constants.OAuth.isSignin) as? Bool ?? false
    }
    
    func storeAccessToken(token: String, tokenSecret: String, userId: String) {
        let userDefault = UserDefaults.standard
        
        userDefault.set(token, forKey: Constants.OAuth.Token)
        userDefault.set(tokenSecret, forKey: Constants.OAuth.TokenSecret)
        userDefault.set(userId, forKey: Constants.OAuth.UserId)
        
        userDefault.set(true, forKey: Constants.OAuth.isSignin)
        client = oAuth?.client
    }
    
    func example(completion: @escaping (GetTwitterResponse) -> ()) {
        
//        let _ = self.clientOAuth?.get("\(self.baseOAuthUrl)search/",
//            
//            parameters: [:],
//            
//            success: { response -> Void in
//                guard let jsonString = response.dataString() else {
//                    completion(GetTwitterResponse.empty)
//                    return
//                }
//                
//                if let dataFromString = jsonString.data(using: .utf8, allowLossyConversion: false) {
//                    completion(.success(JSON(data: dataFromString)))
//                } else {
//                    completion(GetTwitterResponse.empty)
//                }
//                
//        }, failure: { error -> Void in completion(.error(error)) })
    }
}
