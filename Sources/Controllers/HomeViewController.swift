//
//  HomeViewController.swift
//  GetTwitter
//
//  Created by Duy Nguyen on 7/3/17.
//  Copyright © 2017 Duy Nguyen. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        GetTwitterClient.instance.client?.get(
            "https://api.twitter.com/1.1/statuses/home_timeline.json",
            parameters: ["count": 20],
            success: { response in
                guard let jsonString = response.dataString() else {
                    return
                }
                
                print(jsonString)

        },
            failure: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
