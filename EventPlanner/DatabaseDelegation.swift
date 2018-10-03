//
//  Database.swift
//  EventPlanner
//
//  Created by Zaid Aslam Shaikh on 10/8/17.
//  Copyright © 2017 RMIT. All rights reserved.
//

import Foundation

protocol Save {
  
     func save(meettitle: String,vName: String,vAddress: String,guestList: String,meetingTime: String)
        }

protocol Delete {
    
    
     func delete (index: Int)
   
}

protocol Fetch {
    
    
   
     func getDetails()
}

protocol Edit {
    
    
    
     func updateDetails (meetingTitle: String,meetingTime: String,venueName: String,venueAddress: String,contact: String)
}
