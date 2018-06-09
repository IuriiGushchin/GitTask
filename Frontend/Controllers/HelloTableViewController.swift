//
//  HelloTableViewController.swift
//  Frontend
//
//  Created by iMac27 on 08.06.2018.
//  Copyright © 2018 iMac27. All rights reserved.
//

import UIKit

class HelloTableViewController: UITableViewController {
    
    var rssItems : [RSSItem]?
    
//    var name = ""
//    var middlename = ""
//    var shopping : [String] = []
//    var titles = ["Новость1","Новость2","Новость3","Новость4"]
//    var dates = ["12","34","56","78"]
//    var descriptions = ["dafsda","gadfsaf","gdagfafs","You use image objects to represent image data of all kinds, and the UIImage class is capable of managing data for all image formats supported by the underlying platform. Image objects are immutable, so you always create them from existing image data, such as an image file on disk or programmatically created image data. An image object may contain a single image or a sequence of images you intend to use in an animation."]
//
    func fetchData(){
        let feedParser = rssParser()
        print("!")
        feedParser.parseFeed(url: "https://developer.apple.com/news/rss/news.rss") { (rssItems) in
            
            self.rssItems = rssItems
            print(rssItems)
            print("!")
            OperationQueue.main.addOperation {
                self.tableView.reloadSections(IndexSet(integer: 0), with: .left)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("?")
        fetchData()
        print("?")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let rssItems = rssItems else {
            print("error47")
            return 0
        }
        return rssItems.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        let AnyCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! MyCustomCell
        if let item = rssItems?[indexPath.row] {
            AnyCell.item = item
        }
        
        return AnyCell
        
    }
}
