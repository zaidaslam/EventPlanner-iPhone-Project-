//
//  mapViewController.swift
//  EventPlanner
//
//  Created by Swapnil Guha on 9/27/17.
//  Copyright © 2017 RMIT. All rights reserved.
//

import UIKit
import MapKit

class mapViewController: UIViewController, MKMapViewDelegate  {
    
    var venueName:String!
    var venueId:String!
    var venueAddress:String!
    var location:CLLocationCoordinate2D!
    var address:String = ""
    
    var searchResults = [JSON]()
    var intrest:String = ""
 
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        
   
        super.viewDidLoad()
        
       
            // set title
        title = venueName
        
        // set directions button
        let directions = UIBarButtonItem(title: "Directions", style: .plain, target: self, action: #selector(getDirections))
        navigationItem.rightBarButtonItem = directions
        
                let coordinateRegion = MKCoordinateRegionMakeWithDistance(location, 2000, 2000)
                self.mapView.setRegion(coordinateRegion, animated: true)
                
                // add a pin to the map
                self.mapView.delegate = self
                self.mapView.addAnnotation(MapPin(title: "View in Foursquare", name: self.venueName, foursquareId: self.venueId, coordinate: location))
                

                
            
      
    }

     // MARK: - Apple Maps directions
    func getDirections() {
         print(address)
        let loc = mapView.annotations.first as! MapPin
        print(loc.name)
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking]
        loc.mapItem().openInMaps(launchOptions: launchOptions)
    }
    
   
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if let annotation = annotation as? MapPin {
            let identifier = "pin"
            var view: MKPinAnnotationView
            if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
                as? MKPinAnnotationView {
                dequeuedView.annotation = annotation
                view = dequeuedView
            } else {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
            }
            return view
        }
        return nil
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let encodedAddress = ("https://www.foursquare.com/v/"+venueId).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: encodedAddress) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "pickLocation" {
            let vc = segue.destination as! MeetController
            vc.venueName = venueName
            vc.venueAddress = venueAddress
     
     //      print(venueId,"map controller")
            
        }
        if segue.identifier == "venueImages" {
            let vc = segue.destination as! ImgController
           
            print(venueId,"map controller")
                       vc.venueId = venueId
            
        }
    }

    
}



