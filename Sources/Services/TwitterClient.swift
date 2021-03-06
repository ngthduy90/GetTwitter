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
    var consumerKey = "QQykmxcSzF16q1kba6Ah17i04"
    var consumerSecret = "4KBV9MQVrLKPr5rTy5b0IOX2zk5VaAePfIUEeM0IwXGPj0xCrD"
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
    let baseUrl = "https://api.twitter.com/"
    
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
    
    func request(method: OAuthSwiftHTTPRequest.Method,
                 urlString: String,
                 parameters: [String: Any]?,
                 completion: @escaping (GetTwitterResponse) -> ()) {
        
        let fullUrlString = "\(baseUrl)\(urlString)"
                
        client?.request(fullUrlString,
                        
                        method: method,
                        
                        parameters: parameters ?? [:],
                        
                        success: { response in
                            
                            guard let jsonString = response.dataString() else {
                                completion(GetTwitterResponse.empty)
                                return
                            }
                            
                            if let dataFromString = jsonString.data(using: .utf8, allowLossyConversion: false) {
                                
                                completion(.success(JSON(data: dataFromString)))
                            } else {
                                completion(GetTwitterResponse.empty)
                            }
        },
                        failure: { error -> Void in
                            completion(.error(error))
        })
        
    }
    
    func post(urlString: String,
              parameters: [String: Any]?,
              completion: @escaping (GetTwitterResponse) -> ()) {
        
        let fullUrlString = "\(baseUrl)\(urlString)"
        
        _ = client?.post(fullUrlString,
                     
                     parameters: parameters ?? [:],
                     
                     success: { response in
                        
                        guard let jsonString = response.dataString() else {
                            completion(GetTwitterResponse.empty)
                            return
                        }
                        
                        if let dataFromString = jsonString.data(using: .utf8, allowLossyConversion: false) {
                            
                            completion(.success(JSON(data: dataFromString)))
                        } else {
                            completion(GetTwitterResponse.empty)
                        }
        },
                     failure: { error -> Void in
                        completion(.error(error))
        })
        
    }
}
