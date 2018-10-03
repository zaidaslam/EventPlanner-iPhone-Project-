//
//  MeetingCell.swift
//  EventPlanner
//
//  Created by Zaid Aslam Shaikh on 10/7/17.
//  Copyright © 2017 RMIT. All rights reserved.
//

import UIKit

class MeetingCell: UITableViewCell {
    
   
    @IBOutlet weak var meetingTitle: UILabel!
    
    @IBOutlet weak var venueAddress: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
