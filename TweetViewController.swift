//
//  TweetViewController.swift
//  Twitter
//
//  Created by searto  on 10/7/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetViewController: UIViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad()
        TweetTextFeild.becomeFirstResponder()

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var TweetTextFeild: UITextView!
    
    @IBAction func cancel(_ sender: Any)
    {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tweet(_ sender: Any)
    {
        
        if(!TweetTextFeild.text.isEmpty)
        {
            TwitterAPICaller.client?.postTweet(tweetString: TweetTextFeild.text, success: {
                self.dismiss(animated: true, completion: nil)
            }, failure: { (error) in
                print("error posting\(error)")
                self.dismiss(animated: true, completion: nil)
            })
        }
        else
        {
            self.dismiss(animated: true, completion: nil)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
