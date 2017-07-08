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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let composeVC = segue.destination as? ComposeViewController {
            composeVC.delegate = self
        }
        
        if let detailVC = segue.destination as? DetailViewController,
            let tweet = sender as? Tweet {
            
            
        }
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
    
    @IBAction func didTapCompose(_ sender: UIButton) {
        performSegue(withIdentifier: "PresentComposeSegue", sender: nil)
    }

}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "TweetDetailSegue", sender: tweets[indexPath.row])
    }
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

extension HomeViewController: ComposeViewControllerDelegate {
    
    func composeVC(update tweet: Tweet) {
        tweets.insert(tweet, at: 0)
        tweetTable.reloadData()
    }
}
