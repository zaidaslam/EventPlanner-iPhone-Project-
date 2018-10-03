//
//  ListController.swift
//  EventPlanner
//
//  Created by Zaid Aslam Shaikh on 9/22/17.
//  Copyright © 2017 RMIT. All rights reserved.
//

import UIKit
import CoreLocation

let client_id = "FP3VYT1ZP3HE0GZAYPYTPLY1WC1341Q0SD4HZZ5BJHCP5WMS"
let client_secret = "MB0JZYXEPDA2IT0FHVWPCCNVNJRMT0UV1TCVCHXCHR5EWX4N"

class ListController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var currentLocationLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var searchResults = [JSON]()
    var currentLocation:CLLocationCoordinate2D!
    var interest:String = ""
    
    
    
    override func viewDidLoad() {
     
        super.viewDidLoad()
        
       
        currentLocationLabel.text = ""
        currentLocationLabel.isHidden = true
        tableView.isHidden = true
        
       
        tableView.delegate = self
        tableView.dataSource = self
        
       
        getLocation()
        
        
        getList()
        print("list controller",currentLocation)
        print("list",interest)
    }
    
    func getLocation() {
        let url = "https://api.foursquare.com/v2/venues/search?ll=\(currentLocation.latitude),\(currentLocation.longitude)&v=20160607&intent=checkin&limit=1&radius=4000&client_id=\(client_id)&client_secret=\(client_secret)"
        
        let request = NSMutableURLRequest(url: URL(string: url)!)
        let session = URLSession.shared
        
        request.httpMethod = "GET"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, err -> Void in
            
            var currentVenueName:String?
            
            let json = JSON(data: data!)
            currentVenueName = json["response"]["venues"][0]["name"].string
            
                       DispatchQueue.main.async {
                if let v = currentVenueName {
                    self.currentLocationLabel.text = "You're at \(v)."
                }
                self.currentLocationLabel.isHidden = false
            }
        })
        
        task.resume()
    }
    
 
    func getList() {
        let url = "https://api.foursquare.com/v2/search/recommendations?ll=\(currentLocation.latitude),\(currentLocation.longitude)&v=20160607&intent=\(interest)&limit=15&client_id=\(client_id)&client_secret=\(client_secret)"
        print(url)
        let request = NSMutableURLRequest(url: URL(string: url)!)
        let session = URLSession.shared
        
        request.httpMethod = "GET"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, err -> Void in
            
            let json = JSON(data: data!)
            self.searchResults = json["response"]["group"]["results"].arrayValue
            
            DispatchQueue.main.async {
                self.tableView.isHidden = false
                self.tableView.reloadData()
            }
        })
        
        task.resume()
    }
    
   
    
  
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! TableCell
        
        cell.title.text = searchResults[(indexPath as NSIndexPath).row]["venue"]["name"].string
    
        cell.distance.text = "\(searchResults[(indexPath as NSIndexPath).row]["venue"]["location"]["distance"].intValue)m"
        cell.address.text = searchResults[(indexPath as NSIndexPath).row]["venue"]["location"]["address"].string
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
    
    
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == "mapView" {
            
            let vc = segue.destination as! mapViewController
                vc.location = currentLocation

          let selectedCell = tableView.indexPathForSelectedRow!
        
            
          
            vc.venueName = searchResults[(selectedCell as NSIndexPath).row]["venue"]["name"].string
            vc.venueAddress = searchResults[(selectedCell as NSIndexPath).row]["venue"]["location"]["address"].string
            let lat = searchResults[(selectedCell as NSIndexPath).row]["venue"]["location"]["lat"].doubleValue
            let lng = searchResults[(selectedCell as NSIndexPath).row]["venue"]["location"]["lng"].doubleValue
            vc.location = CLLocationCoordinate2D(latitude: lat, longitude: lng)
            vc.venueId = searchResults[(selectedCell as NSIndexPath).row]["venue"]["id"].stringValue
            
         
        }
    }
}
