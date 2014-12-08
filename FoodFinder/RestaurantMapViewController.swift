//
//  RestaurantMapViewController.swift
//  FoodFinder
//
//  Created by Jonathan Disher on 12/8/14.
//  Copyright (c) 2014 Jonathan Disher. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class RestaurantMapViewController: UIViewController {
   
    @IBOutlet weak var mapView: MKMapView!
    var navRestaurant: RestaurantItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(navRestaurant.address(), completionHandler: {(placemarks: [AnyObject]!, error: NSError!) -> Void in
            if let placemark = placemarks?[0] as? CLPlacemark {
                self.mapView.addAnnotation(MKPlacemark(placemark: placemark))
            }
        })
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
