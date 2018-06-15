//
//  MyCustomCell.swift
//  Frontend
//
//  Created by iMac27 on 08.06.2018.
//  Copyright © 2018 iMac27. All rights reserved.
//

import UIKit

class MyCustomCell: UITableViewCell {

    
    @IBOutlet weak var pubTitleLabel: UILabel!
    
    @IBOutlet weak var pubDateLabel: UILabel!
    
    @IBOutlet weak var pubDescriptoin: UILabel!
    
    var item : RSSItem!{
        didSet{
            pubTitleLabel.text = item.title
            pubDateLabel.text = item.pubDate
            pubDescriptoin.text = item.description
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
}
