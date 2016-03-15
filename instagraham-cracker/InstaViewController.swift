//
//  InstaViewController.swift
//  instagraham-cracker
//
//  Created by Stef Epp on 3/13/16.
//  Copyright © 2016 Stef Epp. All rights reserved.
//

import UIKit
import Parse

class InstaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var userStuff : [PFObject]?
    var refresh : UIRefreshControl!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        
        self.refresh = UIRefreshControl()
        self.refresh.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refresh.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refresh)
        
        let list = PFQuery(className: "userStuff")
        list.orderByDescending("_created_at")
        list.limit = 20
        list.findObjectsInBackgroundWithBlock { (media: [PFObject]?, error: NSError?) -> Void in
            if media != nil {
                self.userStuff = media
                self.tableView.reloadData()
            } else {
                print(error?.localizedDescription)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if userStuff != nil {
            return userStuff!.count
        }
        else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FeedCellTableViewCell", forIndexPath: indexPath) as! FeedCellTableViewCell
        let us = userStuff![indexPath.row]
        cell.FeedLabel.text = us["caption"] as? String
        
        let image = us["media"] as! PFFile
        image.getDataInBackgroundWithBlock {
            (imageData: NSData?, error: NSError?) -> Void in
            if error == nil {
                if let imageData = imageData {
                    let image = UIImage(data:imageData)
                    cell.feedImages.image = image
                }
            }
        }
        return cell
    }
    
    func refresh(sender: AnyObject) {
        let query = PFQuery(className: "userStuff")
        query.orderByDescending("_created_at")
        query.limit = 20
        
        query.findObjectsInBackgroundWithBlock { (userStuff: [PFObject]?, error: NSError?) -> Void in
            if userStuff != nil {
                self.userStuff = userStuff
                self.tableView.reloadData()
            } else {
                print(error?.localizedDescription)
            }
        }
        self.refresh.endRefreshing()
    }
    
    @IBAction func logOutClicked(sender: AnyObject) {
        PFUser.logOutInBackgroundWithBlock { (error: NSError?) -> Void in
            if error == nil {
                self.performSegueWithIdentifier("logout", sender: nil)
            }

        }
        
    }

}
