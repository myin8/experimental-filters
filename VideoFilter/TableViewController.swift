//
//  TableViewController.swift
//  VideoFilter
//
//  Created by Maimaitiming Abudukadier on 2/11/16.
//  Copyright © 2016 Maimaitiming Abudukadier. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    var dataArray = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()

        for i:Int in 1...16 {
            dataArray.append("Video\(i)")
        }
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        clearsSelectionOnViewWillAppear = true
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        cell.textLabel?.text = dataArray[indexPath.row]
        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let fileName = dataArray[indexPath.row] as String
        let videoUrl = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(fileName, ofType: "mp4")!)
        performSegueWithIdentifier("segue Play Video", sender: videoUrl)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let url = sender as? NSURL else {
            return
        }
        if segue.identifier == "segue Play Video" {
            if let playVC = segue.destinationViewController as? PlayVC {
                playVC.videoUrl = url
            }
        }
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return false
    }
}
