//
//  ImagesController.swift
//  EventPlanner
//
//  Created by Swapnil Guha on 9/28/17.
//  Copyright © 2017 RMIT. All rights reserved.
//

import UIKit
import CoreData

class ToDoListController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var names: [String] = []
    var people: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "To Do List"
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "Cell")
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
            NSFetchRequest<NSManagedObject>(entityName: "Person")
        
        //3
        do {
            people = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    
    @IBAction func addName(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add Task",
                                      message: "Add New Task",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) {
            [unowned self] action in
            
            guard let textField = alert.textFields?.first,
                let nameToSave = textField.text else {
                    return
            }
            
            self.save(name: nameToSave)
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        
        alert.addTextField()
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
                      delete(index: indexPath.row)
            people.remove(at: indexPath.row)
           
            tableView.deleteRows(at: [indexPath],  with: UITableViewRowAnimation.automatic)
            
            
        }
    }
    
    
    func delete (index: Int) {
        
        let context = getContext()
        

      
        
        do {
                 print("------------------>",index)
                  context.delete(people[index] as NSManagedObject)
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

    
    
    

    
    func save(name: String) {
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        // 2
        let entity =
            NSEntityDescription.entity(forEntityName: "Person",
                                       in: managedContext)!
        
        let person = NSManagedObject(entity: entity,
                                     insertInto: managedContext)
        
        // 3
        person.setValue(name, forKeyPath: "name")
        
        // 4
        do {
            try managedContext.save()
            people.append(person)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
}


extension ToDoListController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {
            
            let person = people[indexPath.row]
            let cell =
                tableView.dequeueReusableCell(withIdentifier: "Cell",
                                              for: indexPath)
            cell.textLabel?.text =
                person.value(forKeyPath: "name") as? String
            return cell
    }
}
