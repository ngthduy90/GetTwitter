//
//  HomeViewController.swift
//  GetTwitter
//
//  Created by Duy Nguyen on 7/3/17.
//  Copyright © 2017 Duy Nguyen. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tweetTable: UITableView!
    
    var refreshControll: UIRefreshControl!
    var tweets = [Tweet]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetTable.delegate = self
        tweetTable.dataSource = self
        tweetTable.estimatedRowHeight = 400.0
        tweetTable.rowHeight = UITableViewAutomaticDimension
        
        refreshControll = UIRefreshControl()
        refreshControll.addTarget(self, action: #selector(fetchTweets), for: .valueChanged)
        tweetTable.insertSubview(refreshControll, at: 0)
        
        fetchTweets()
    }
    
    func fetchTweets() {
        
        TweetWorkers.fetchTwentyTweets {
            if let tweets = $0 {
                self.tweets = tweets
                self.tweetTable.reloadData()
                self.refreshControll.endRefreshing()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension HomeViewController: UITableViewDelegate {
    
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetTableViewCell
        
        cell.display(tweet: tweets[indexPath.row])
        
        return cell
    }
}
