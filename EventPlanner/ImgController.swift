//
//  ListController.swift
//  EventPlanner
//
//  Created by Zaid Aslam Shaikh on 9/22/17.
//  Copyright © 2017 RMIT. All rights reserved.
//

import UIKit
import CoreLocation

let c_id = "FP3VYT1ZP3HE0GZAYPYTPLY1WC1341Q0SD4HZZ5BJHCP5WMS" // visit developer.foursqure.com for API key
let c_secret = "MB0JZYXEPDA2IT0FHVWPCCNVNJRMT0UV1TCVCHXCHR5EWX4N" // visit developer.foursqure.com for API key

class ImgController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var venueId:String!
     @IBOutlet weak var tableView: UITableView!
    
    var searchResults = [JSON]()
        var intrest:String = ""
   
    
    
    
    override func viewDidLoad() {
      
        super.viewDidLoad()
        
       
        tableView.isHidden = true
        
       
       tableView.delegate = self
        tableView.dataSource = self
        
        
        
        getImages()
                  }
    
    
   
    func getImages() {
        let v_Id = venueId!
        let url = "https://api.foursquare.com/v2/venues/\(v_Id)/photos/?venuePhotos=1&client_id=\(c_id)&client_secret=\(c_secret)&v=20131124"
        print(url)
        let request = NSMutableURLRequest(url: URL(string: url)!)
        let session = URLSession.shared
        
        request.httpMethod = "GET"
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {data, response, err -> Void in
            
            let json = JSON(data: data!)
            self.searchResults = json["response"]["photos"]["items"].arrayValue
            
            DispatchQueue.main.async {
               self.tableView.isHidden = false
                print(self.searchResults.count)
                self.tableView.reloadData()
            }
        })
        
        task.resume()
    }
    
    
    
    
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "imgCell", for: indexPath) as! imgCell
        
        let prefix = searchResults[(indexPath as NSIndexPath).row]["prefix"]
        let suffix = searchResults[(indexPath as NSIndexPath).row]["suffix"]
        let size = "500x500"
        let  imgURL = "\(prefix)\(size)\(suffix)"
      
        
       
        cell.imgView.downloadImage(from: imgURL)
   
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           }
    
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
        if segue.identifier == "mapView" {
            
            let vc = segue.destination as! mapViewController
            
            let selectedCell = tableView.indexPathForSelectedRow!
            
                       vc.venueName = searchResults[(selectedCell as NSIndexPath).row]["venue"]["name"].string
            let lat = searchResults[(selectedCell as NSIndexPath).row]["venue"]["location"]["lat"].doubleValue
            let lng = searchResults[(selectedCell as NSIndexPath).row]["venue"]["location"]["lng"].doubleValue
            vc.location = CLLocationCoordinate2D(latitude: lat, longitude: lng)
            vc.venueId = searchResults[(selectedCell as NSIndexPath).row]["venue"]["id"].stringValue
            
           
        }
    }
}

extension UIImageView {
    func downloadImage(from url: String) {
        let urlRequest = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data,response,error) in
            if error != nil {
        //        print(error ?? default value)
                return
            }
            
            DispatchQueue.main.async {
                self.image = UIImage(data: data!)
            }
    }
        task.resume()

}
}

