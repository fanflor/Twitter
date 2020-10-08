//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by searto  on 9/30/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell
{

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    
    @IBOutlet weak var retweetButton: UIButton!
    
    @IBOutlet weak var favButton: UIButton!
    var favorite:Bool = false
    var tweetId = -1
    var retweeted = false
    @IBAction func favTweet(_ sender: Any)
    {
        let toBeFav = !favorite
        if(toBeFav)
        {
            TwitterAPICaller.client?.favoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(true)
            }, failure: { (error) in
                print("Favorite did not succeed: \(error)")
            })
            
        }
        else
        {
            TwitterAPICaller.client?.unfavoriteTweet(tweetId: tweetId, success: {
                self.setFavorite(false)
            }, failure: { (error) in
                print("UnFavorite did not succeed \(error)")
            })
        }
    }
    
    @IBAction func reTweet(_ sender: Any)
    {
        TwitterAPICaller.client?.reTweet(tweetId: tweetId, success: {
            self.SetRetweeted(true)
        }, failure: { (error) in
            print("Error is retweeting: \(error)")
        })
        
    }
    
    func SetRetweeted(_ isretweeted:Bool)
    {
        if(isretweeted)
        {
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
        }
        else
        {
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retweetButton.isEnabled = true
            
        }
    }
 
    func setFavorite(_ isFavorite:Bool)
    {
        favorite=isFavorite
        if(favorite)
        {
            favButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        }
        else
        {
            favButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
        
    }
    
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
