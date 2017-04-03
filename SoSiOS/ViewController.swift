//
//  ViewController.swift
//  SoSiOS
//
//  Created by Austin D. Schalk on 1/27/17.
//  Copyright © 2017 Austin D. Schalk. All rights reserved.
//


import UIKit
import MapKit
import CoreLocation
import Firebase
import FirebaseCore
import FirebaseAuth



class ViewController: UIViewController, CLLocationManagerDelegate {
    //Record location data and crowdsource to server for external app
    @IBOutlet weak var SaveCrowdsource: UIButton!
    
    
//Map
    
    @IBOutlet weak var UserLocation: MKMapView!
    
    let manager = CLLocationManager()
    
        override func viewDidLoad() {
        super.viewDidLoad()
  //set the intial zoom when opening the map
            let span: MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
            let location:CLLocationCoordinate2D = CLLocationCoordinate2DMake(33.325713, -111.926286)
            let region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
            UserLocation.setRegion(region, animated: true)
    //set specific annotations on the map
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            annotation.title = "My Location"
            annotation.subtitle = "Do you need help?"
            UserLocation.addAnnotation(annotation)
 //set the location to the user if the app               
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
            // Do any additional setup after loading the view, typically from a nib.
            
            
            func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
                let userLocation:CLLocation = locations[0] as CLLocation
                
                // Call stopUpdatingLocation() to stop listening for location updates,
                // other wise this function will be called every time when user location changes.
                
                // manager.stopUpdatingLocation()
                
                print("user latitude = \(userLocation.coordinate.latitude)")
                print("user longitude = \(userLocation.coordinate.longitude)")
            }
            
            func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
            {
                print("Error \(error)")
            }

    }

    @IBAction func help(_ sender: Any) {
    
        
        let signInPopUp = UIAlertController.init(title: "Please sign in with your Google Account and password", message: nil, preferredStyle: .alert)
        signInPopUp.addTextField(configurationHandler: { (textField) in
        
        //configure text field
            textField.placeholder = "Email"
        })
        signInPopUp.addTextField(configurationHandler: { (textField) in
            textField.placeholder = "Password"
            //configure text field
            textField.isSecureTextEntry = true
        })
        signInPopUp.addAction(UIAlertAction.init(title: "Sign In", style: .default, handler: { (action) in
            
            signInPopUp.textFields?[0]
        
        //Do something on action
        }))
        
        self.present(signInPopUp, animated: true, completion: nil)
        
        
        //SwiftSpinner.show("Sending Location")
        SwiftSpinner.show(duration: 3, title: "Broadcasting Location", animated: true)
        
        FIRAuth.auth()?.addStateDidChangeListener({ (auth, user) in
            if ((user) != nil) {
                var email = user?.email
                
            }
        })
        FIRAuth.auth()?.signIn(withEmail: "",
            password: "",
            completion: { (_, error) in
            if ((error) != nil) {
                                                
            }
        })
        
        //SwiftSpinner.hide()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

