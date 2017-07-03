//
//  TweetTableViewCell.swift
//  GetTwitter
//
//  Created by Duy Nguyen on 7/4/17.
//  Copyright © 2017 Duy Nguyen. All rights reserved.
//

import UIKit
import AFNetworking

class TweetTableViewCell: UITableViewCell {
    
    @IBOutlet weak var retweetStackView: UIStackView!
    @IBOutlet weak var retweetLabel: UILabel!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var contentHeaderStackView: UIStackView!
    @IBOutlet weak var contentTitleLabel: UILabel!
    @IBOutlet weak var contentDescriptionLabel: UILabel!
    
    var tweet: Tweet?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func display(tweet: Tweet?) {
        
        guard let tweet = tweet else {
            return
        }
        
        self.tweet = tweet
        var displayTweet = tweet
        
        if let retweet = tweet.retweet {
            displayTweet = retweet
            self.retweetLabel.text = "\(tweet.user.displayName) Retweeted"
            
            retweetStackView.isHidden = false
        } else {
            retweetStackView.isHidden = true
        }
        
        self.contentTitleLabel.text = displayTweet.user.displayName
        self.contentDescriptionLabel.text = displayTweet.text
        self.profileImageView.setImageWith(URL(string: displayTweet.user.profileImageUrl)!)
        
    }

}
