//
//  LoginViewController.swift
//  GetTwitter
//
//  Created by Duy Nguyen on 7/3/17.
//  Copyright © 2017 Duy Nguyen. All rights reserved.
//

import UIKit
import OAuthSwift
import ChameleonFramework

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        renderButtons()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        checkUserState()
    }

    @IBAction func didTapLogin(_ sender: Any) {
        
        GetTwitterClient.instance.oAuth?.authorize(
            
            withCallbackURL: URL(string: "ntduy-GetTwitter://oauth-callback")!,
            
            success: { credential, response, parameters in
                
                GetTwitterClient.instance.storeAccessToken(
                    token: credential.oauthToken,
                    tokenSecret: credential.oauthTokenSecret,
                    userId: parameters["user_id"] as? String ?? "-1"
                )
                
                self.performSegue(withIdentifier: Constants.Segue.HomeSegue, sender: nil)
                
        }, failure: { error in
            print(error.localizedDescription)
        }
        )
    }
    
    private func renderButtons() {
        loginButton.layer.cornerRadius = 16.0
        loginButton.layer.borderWidth = 2.0
        loginButton.layer.borderColor = HexColor("03A9F4")!.cgColor
        loginButton.setTitleColor(HexColor("03A9F4"), for: .normal)
    }
    
    private func checkUserState() {
        guard GetTwitterClient.instance.client != nil else {
            return
        }
        
        self.performSegue(withIdentifier: Constants.Segue.HomeSegue, sender: nil)
    }
    
}
