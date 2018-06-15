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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    
    
    func fetchData(){
        let feedParser = rssParser()
        print("!")
        feedParser.parseFeed(url: "https://developer.apple.com/news/rss/news.rss") { (rssItems) in
            print("!")
            self.rssItems = rssItems
            print(rssItems)
            print("!")
            OperationQueue.main.addOperation {
                self.tableView.reloadSections(IndexSet(integer: 0), with: .left)
            }
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
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
