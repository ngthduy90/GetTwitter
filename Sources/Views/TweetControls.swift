//
//  TweetControls.swift
//  GetTwitter
//
//  Created by Duy Nguyen on 7/9/17.
//  Copyright © 2017 Duy Nguyen. All rights reserved.
//

import UIKit

class TweetControls: BaseNibView {
    
    @IBOutlet weak var replyImageView: UIImageView!
    @IBOutlet weak var replyQuantityLabel: UILabel!
    @IBOutlet weak var retweetImageView: UIImageView!
    @IBOutlet weak var retweetQuantityLabel: UILabel!
    @IBOutlet weak var loveImageView: UIImageView!
    @IBOutlet weak var loveQuantityLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    @IBAction func didTapReply(_ sender: UITapGestureRecognizer) {
        replyImageView.isHighlighted = !replyImageView.isHighlighted
    }
    
    @IBAction func didTapRetweet(_ sender: UITapGestureRecognizer) {
        retweetImageView.isHighlighted = !retweetImageView.isHighlighted
    }
    
    @IBAction func didTapLove(_ sender: UITapGestureRecognizer) {
        loveImageView.isHighlighted = !loveImageView.isHighlighted
    }
    
    
}
