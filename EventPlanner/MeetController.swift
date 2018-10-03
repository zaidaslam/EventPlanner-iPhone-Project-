//
//  MeetController.swift
//  EventPlanner
//
//  Created by Swapnil Guha on 10/6/17.
//  Copyright © 2017 RMIT. All rights reserved.
//

import UIKit
import CoreData
import ContactsUI

class MeetController: UIViewController , CNContactPickerDelegate,Save{
    
    var venueName:String!
    var venueAddress:String!
    var names: [String] = []
    var mTitle: [NSManagedObject] = []
    var mDetails: [NSManagedObject] = []
    var guestName = ""
 
    
    
    @IBOutlet weak var meetingTitle: UITextField!
    @IBOutlet weak var vName: UITextField!
    @IBOutlet weak var vAddress: UITextField!
    @IBOutlet weak var pickContact: UIButton!
    @IBOutlet weak var guestList: UITextField!
    @IBOutlet weak var meetingTime: UITextField!
  
    
    
    @IBOutlet weak var meetingList: UIButton!
    
    

   
    @IBOutlet weak var meetingButton: UIButton!
    
    let datePicker = UIDatePicker()
    
   
   
    @IBAction func addDetails(_ sender: Any) {
        save(meettitle: meetingTitle.text!,vName: vName.text!,vAddress: vAddress.text!,guestList: guestList.text!,meetingTime: meetingTime.text!)
   
    }
    
    @IBAction func click_Contact(_ sender: Any) {
        let cnPicker = CNContactPickerViewController()
        cnPicker.delegate = self
        self.present(cnPicker, animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vName.text = venueName
        vAddress.text = venueAddress
        meetingTitle.text = "Event Title "
        guestList.text = "Pick Contact"
        meetingTime.text = "Enter Event Time"
       
       
        
        createDatePicker()

  
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contacts: [CNContact]) {
        names.removeAll()
        contacts.forEach {
            
            contact in
            let name = contact.givenName
            
            names.append(name)
                  }
        var guestName = ""
        
        for i in 0 ..< names.count  {
            guestName = "\(guestName) \(names[i])"
            
                    }

        guestList.text = guestName
    }
    
    

    
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        print("Cancel Contact Picker")
    }
    
    func createDatePicker() {
        
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil , action: #selector(donePressed))
        
        toolbar.setItems([doneButton], animated: false)
        
        meetingTime.inputAccessoryView = toolbar
        
        meetingTime.inputView = datePicker
        
    }

    
    func donePressed(){
        meetingTime.text = "\(datePicker.date)"
        self.view.endEditing(true)
    }
    
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    

    
    func save(meettitle: String,vName: String,vAddress: String,guestList: String,meetingTime: String) {
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        
       
        let entityDetails =
            NSEntityDescription.entity(forEntityName: "MeetingDetail",
                                       in: managedContext)!
        
        
        
        let meetDetails = NSManagedObject(entity: entityDetails,
                                        insertInto: managedContext)
        
        
        
         meetDetails.setValue(meettitle, forKeyPath: "meetingTitle")
        meetDetails.setValue(vName, forKeyPath: "venueName")
        meetDetails.setValue(vAddress, forKeyPath: "venueAddress")
        meetDetails.setValue(guestList, forKeyPath: "guestList")
        meetDetails.setValue(meetingTime, forKeyPath: "meetingTime")
      
        
     
        do {
            try managedContext.save()
         
            mDetails.append(meetDetails)
            print("saved")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}


