//
//  TableCell.swift
//  EventPlanner
//
//  Created by Zaid Aslam Shaikh on 9/22/17.
//  Copyright © 2017 RMIT. All rights reserved.
//

import UIKit

class TableCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var address: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
