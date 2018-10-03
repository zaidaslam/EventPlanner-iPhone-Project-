//
//  MeetDetails.swift
//  EventPlanner
//
//  Created by Swapnil Guha on 10/6/17.
//  Copyright © 2017 RMIT. All rights reserved.
//


import UIKit
import CoreData

class MeetDetails: UIViewController,Fetch {
    
       
    var index = 0
    
    @IBOutlet weak var meetingTitle: UILabel!
    @IBOutlet weak var venueName: UILabel!
    @IBOutlet weak var venueAddress: UILabel!
    @IBOutlet weak var guestList: UILabel!
    @IBOutlet weak var meetingTime: UILabel!
    @IBOutlet weak var notes: UILabel!
    
    
    
    
    var mTitle: [NSManagedObject] = []

    override func viewDidLoad() {
       
        super.viewDidLoad()
     
        getDetails()
    }
    
    
    
    
    func getDetails() {
       
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
       
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "MeetingDetail")
        
        
        do {
            mTitle = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        let title = mTitle[index]
        meetingTitle.text = title.value(forKey: "meetingTitle") as? String
        meetingTime.text = title.value(forKeyPath: "meetingTime") as? String
        venueName.text = title.value(forKeyPath: "venueName") as? String
        venueAddress.text = title.value(forKeyPath: "venueAddress") as? String
        guestList.text = title.value(forKeyPath: "guestList") as? String
        
        
        
            }
    
        func getContext () -> NSManagedObjectContext {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            return appDelegate.persistentContainer.viewContext
        }

    
    
    
          func deleteUser () {
        
                let context = getContext()
        
                             let fetchRequest: NSFetchRequest<MeetingDetail> = MeetingDetail.fetchRequest()
        
                do {
                                      let array_users = try getContext().fetch(fetchRequest)
        
                                     for user in array_users as [NSManagedObject] {
                      
                        context.delete(user)
                        
                        
        
                    }
                          
                    do {
                        try context.save()
                        print("saved!")
                    } catch let error as NSError  {
                        print("Could not save \(error), \(error.userInfo)")
                    } catch {
                        
                    }
                    
                } catch {
                    print("Error with request: \(error)")
                }
            }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        let vc = segue.destination as! EditDetails
        vc.index = index
        
        
    }

    
  }
