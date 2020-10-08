//
//  HomeTableViewController.swift
//  Twitter
//
//  Created by searto  on 9/30/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController
{
    var tweetArray = [NSDictionary]()
    var numberOfTweet: Int!
    
    let myRefreshControl = UIRefreshControl()
    override func viewDidLoad()
    {
        super.viewDidLoad()
        numberOfTweet=20
        myRefreshControl.addTarget(self, action: #selector(loadTweet), for: .valueChanged)
        tableView.refreshControl = myRefreshControl
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 150 //3..12
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        self.loadTweet()
        super.viewDidAppear(animated)
        
    }
    
    @objc func loadTweet()
    {
        
        
        let myUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        
        let myParams = ["count":numberOfTweet]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParams as [String : Any], success: { (tweet: [NSDictionary]) in
            
            self.tweetArray.removeAll()
            
            for tweet in tweet
            {
                self.tweetArray.append(tweet)
            }
            
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
            
        }, failure: { (Error) in
            print("could not retrive tweets! oh no!!")
        })
    }
    
    
    func loadMoreTweet()
    {
        let myUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
        numberOfTweet = numberOfTweet+20
        let myParams = ["count":numberOfTweet]
        
        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParams as [String : Any], success: { (tweet: [NSDictionary]) in
            
            self.tweetArray.removeAll()
            
            for tweet in tweet
            {
                self.tweetArray.append(tweet)
            }
            
            self.tableView.reloadData()
            
        }, failure: { (Error) in
            print("could not retrive tweets! oh no!!")
        })
        
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) 
     {
        if indexPath.row + 1 == tweetArray.count
        {
            loadMoreTweet()
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func onLogout(_ sender: Any)
    {
        TwitterAPICaller.client?.logout()
        self.dismiss(animated: true, completion: nil)
        
        UserDefaults.standard.set(true, forKey: "userLoggedIn")
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell=tableView.dequeueReusableCell(withIdentifier: "tweetcell", for: indexPath) as! TweetTableViewCell
        
        let user = tweetArray[indexPath.row]["user"] as! NSDictionary
        
        cell.userNameLabel.text = user["name"] as? String
        cell.tweetContent.text = tweetArray[indexPath.row]["text"] as? String
        
        let imageUrl = URL(string:(user["profile_image_url_https"] as? String)!)
        let data = try? Data(contentsOf: imageUrl!)
        
        if let imageData = data
        {
            cell.profileImage.image = UIImage(data: imageData)
        }
        //pt2
        cell.setFavorite(tweetArray[indexPath.row]["favorited"] as! Bool)
        cell.tweetId = tweetArray[indexPath.row]["id"]as! Int
        cell.SetRetweeted(tweetArray[indexPath.row]["retweeted"] as! Bool)
     
        return cell
    }
    
    
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweetArray.count
    }
    
    
    
}
