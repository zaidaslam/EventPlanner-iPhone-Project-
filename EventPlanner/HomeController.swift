//
//  HomeController.swift
//  EventPlanner
//
//  Created by Swapnil Guha on 10/4/17.
//  Copyright © 2017 RMIT. All rights reserved.
//
import UIKit
import CoreLocation
import MapKit

fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l > r
    default:
        return rhs < lhs
    }
}

class HomeController: UIViewController,CLLocationManagerDelegate{
    
    let locationManager = CLLocationManager()
    var currentLocation:CLLocationCoordinate2D!
    var flag = true
    var check = false
    var interest:String = ""

    @IBOutlet weak var food: UIButton!
    
    @IBOutlet weak var movie: UIButton!
    
    
    @IBOutlet weak var shopping: UIButton!
    
    @IBOutlet weak var attraction: UIButton!
    
    
    @IBAction func food(_ sender: Any) {
        interest = "food"
         getCurrentLocation()
    }
    
    @IBAction func movie(_ sender: Any) {
        interest = "movie"
         getCurrentLocation()
    }
    
    
    @IBAction func shopping(_ sender: Any) {
        interest = "shopping"
         getCurrentLocation()
    }
    
    
    @IBAction func attraction(_ sender: Any) {
        interest = "fun"
         getCurrentLocation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.locationManager.requestWhenInUseAuthorization()
        title = "Home"
        flag = true
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        getCurrentLocation()
        
    }
    
    func getCurrentLocation() {
        
        if CLLocationManager.locationServicesEnabled() {
            switch(CLLocationManager.authorizationStatus()) {
            case .authorizedWhenInUse:
                locationManager.startUpdatingLocation()
            default:
                showLocationAlert()
            }
        } else {
            showLocationAlert()
        }
        
    }
    func showLocationAlert() {
        let alert = UIAlertController(title: "Location Disabled", message: "Please enable location for this APP", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        if locations.last?.timestamp.timeIntervalSinceNow < -30.0 || locations.last?.horizontalAccuracy > 80 {
            return
        }
        
        
        if flag {
            currentLocation = locations.last?.coordinate
            print(currentLocation)
            check = true
            locationManager.stopUpdatingLocation()
            flag = false
            
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        getCurrentLocation()
        
        
        if segue.identifier == "listView" {
        if  check {
           
                print("home controller",interest)
                let vc = segue.destination as! ListController
            
                vc.currentLocation = currentLocation
                vc.interest = interest
            
            
        }else {
            showLocationAlert()
        }
        }
           }

    
    
  }
