//
//  ComposeViewController.swift
//  GetTwitter
//
//  Created by Duy Nguyen on 7/8/17.
//  Copyright © 2017 Duy Nguyen. All rights reserved.
//

import UIKit
import AFNetworking

protocol ComposeViewControllerDelegate: class {
    
    func composeVC(update tweet: Tweet)
}

class ComposeViewController: UIViewController {
    
    @IBOutlet weak var composeView: UIView!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var contentTextField: UITextField!
    @IBOutlet weak var tweetButton: UIButton!
    @IBOutlet weak var coundDownLabel: UILabel!
    
    @IBOutlet weak var verticalAlignmentConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightComposeConstraint: NSLayoutConstraint!
    
    var maximumChars = 140
    weak var delegate: ComposeViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        render()
        refreshCoundown(with: "")
        
        avatarImageView.setImageWith(URL(string: UserWorkers.currentUser!.profileImageUrl)!)
        
        contentTextField.delegate = self
        contentTextField.becomeFirstResponder()
    }
    
    @IBAction func didTapClose(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func didTapTweet(_ sender: UIButton) {
        
        guard let content = contentTextField.text, !(contentTextField.text?.isEmpty ?? false) else {
            return
        }
        
        TweetWorkers.postNewTweet(content) {
            if let tweet = $0 {
                self.delegate?.composeVC(update: tweet)
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    fileprivate func render() {
        composeView.layer.cornerRadius = 16.0
        avatarImageView.layer.cornerRadius = 35.0
        tweetButton.layer.cornerRadius = 20.0
    }
    
    fileprivate func refreshCoundown(with string: String) {
        coundDownLabel.text = "\(maximumChars - string.characters.count)"
    }
    
    fileprivate func isAllowNewContent(_ string: String) -> Bool {
        
        return maximumChars >= string.characters.count
    }
    
}

extension ComposeViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentContentString: NSString = contentTextField.text! as NSString
        let newText = currentContentString.replacingCharacters(in: range, with: string)
        
        var allowed: Bool = false
        
        if isAllowNewContent(newText) {
            refreshCoundown(with: newText)
            allowed = true
        }
        
        return allowed
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        verticalAlignmentConstraint.constant = composeView.frame.size.height / 3 * -1
        self.view.layoutIfNeeded()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        verticalAlignmentConstraint.constant = 0
        self.view.layoutIfNeeded()
    }
}
