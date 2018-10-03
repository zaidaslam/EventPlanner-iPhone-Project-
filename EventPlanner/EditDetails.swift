//
//  EditDetails.swift
//  EventPlanner
//
//  Created by Zaid Aslam Shaikh on 10/7/17.
//  Copyright © 2017 RMIT. All rights reserved.
//

import UIKit
import CoreData
import ContactsUI

class EditDetails: UIViewController,CNContactPickerDelegate,Edit {

    var mTitle: [NSManagedObject] = []
     var guestName = ""
     var names: [String] = []
    var index = 0
    @IBOutlet weak var meetingTitle: UITextField!
    
    
    @IBOutlet weak var venueName: UITextField!
    
    @IBOutlet weak var venueAddress: UITextField!
    
    @IBOutlet weak var contact: UITextField!
    
    @IBOutlet weak var meetingTime: UITextField!
    
    
    @IBAction func pickContacts(_ sender: Any) {
        let cnPicker = CNContactPickerViewController()
        cnPicker.delegate = self
        self.present(cnPicker, animated: true, completion: nil)
    }
    
    @IBOutlet weak var pickContact: UIButton!
    @IBOutlet weak var done: UIButton!
    
    let datePicker = UIDatePicker()
    
    
    @IBAction func updateDetail(_ sender: Any) {
        
        
        updateDetails(meetingTitle: meetingTitle.text!, meetingTime: meetingTime.text!, venueName: venueName.text!, venueAddress: venueAddress.text!, contact: contact.text!)
    }
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         createDatePicker()
         getDetails()
    
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
        
        contact.text = guestName
    }
    
    
    
    
    
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        print("Cancel Contact Picker")
    }

    
    func createDatePicker() {
        
        // datePicker.datePickerMode = .date
        
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
        
    
    func updateDetails (meetingTitle: String,meetingTime: String,venueName: String,venueAddress: String,contact: String) {
        
                let context = getContext()
                let fetchRequest: NSFetchRequest<MeetingDetail> = MeetingDetail.fetchRequest()
        
                do {
                    let array_users = try getContext().fetch(fetchRequest)
                    let details = array_users[index]
       
                    details.setValue(meetingTitle, forKey: "meetingTitle")
                     details.setValue(venueName, forKey: "venueName")
                     details.setValue(venueAddress, forKey: "venueAddress")
                     details.setValue(meetingTime, forKey: "meetingTime")
                     details.setValue(contact, forKey: "guestList")
                    
      
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

    
    
    func getDetails() {
        //1
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "MeetingDetail")
        
        //3
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
        contact.text = title.value(forKeyPath: "guestList") as? String
             
        
        
    }
    


}
