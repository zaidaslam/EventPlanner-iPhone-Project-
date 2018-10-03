//
//  MeetingListController.swift
//  EventPlanner
//
//  Created by Swapnil Guha on 10/6/17.
//  Copyright © 2017 RMIT. All rights reserved.
//

import UIKit
import CoreData


class MeetingListController: UIViewController,UITableViewDelegate, UITableViewDataSource,Delete{
    var names: [String] = []
    var mTitle: [NSManagedObject] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    
   
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
   
        
    }
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
    }
    
    
    
    
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
                       delete(index: indexPath.row)
            mTitle.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath],  with: UITableViewRowAnimation.automatic)
            
            
        }
    }
    
    
    func delete (index: Int) {
        
        let context = getContext()
        
        
        
        
        do {
                       context.delete(mTitle[index] as NSManagedObject)
            
            do {
                try context.save()
                print(" delete saved!")
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            } catch {
                
            }
            
        } catch {
            print("Error with request: \(error)")
        }
    }


    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                   let vc = segue.destination as! MeetDetails
        
            
            let selectedCell = tableView.indexPathForSelectedRow!.row
         vc.index = selectedCell
              print(selectedCell)
    
      
        
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return mTitle.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            
            let title = mTitle[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! MeetingCell
                                            
       
            cell.meetingTitle.text = title.value(forKeyPath: "meetingTitle") as? String
            cell.venueAddress.text = title.value(forKeyPath: "venueAddress") as? String
            
            return cell
            
    }
    
    func tableView(_ didSelectRowAttableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        
        let row = indexPath.row
        print(row)
        
    }


}


