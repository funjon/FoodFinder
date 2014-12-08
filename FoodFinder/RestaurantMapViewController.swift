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

class RestaurantMapViewController: UIViewController, CLLocationManagerDelegate {
    var currentPlacemark:CLPlacemark = CLPlacemark()
    var destLoc:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: CLLocationDegrees(0), longitude: CLLocationDegrees(0))
    
    
    var destLat:CLLocationDegrees = CLLocationDegrees()
    var destLon:CLLocationDegrees = CLLocationDegrees()
    
    var currentLatitude:CLLocationDegrees = CLLocationDegrees()
    var currentLongitude:CLLocationDegrees = CLLocationDegrees()
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var nearby: UIButton!
    @IBOutlet weak var directions: UIButton!
    
    var navRestaurant: RestaurantItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.showsUserLocation = true
        
//        var locationManager = CLLocationManager()
//        locationManager.requestWhenInUseAuthorization()
//        NSLog("Requesting auth inside viewDidLoad")
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(navRestaurant.address(), completionHandler: {(placemarks: [AnyObject]!, error: NSError!) -> Void in
            if let placemark = placemarks?[0] as? CLPlacemark {
                self.destLoc = placemark.location.coordinate
                var annotation = MKPointAnnotation()
                annotation.title = self.navRestaurant.name()
                annotation.subtitle = self.navRestaurant.address()
                annotation.coordinate = placemark.location.coordinate
                
                var region = MKCoordinateRegionMakeWithDistance(annotation.coordinate, 1500, 1500)
                self.mapView.setRegion(region, animated: true)
                
                self.mapView.addAnnotation(annotation)
                self.mapView.selectAnnotation( annotation, animated: true)
            }
        })
        
        
        let span = MKCoordinateSpanMake(0.05, 0.05)
    }
    
    
    @IBAction func showDirections(sender: AnyObject) {
        var locationManager = CLLocationManager()
//        var destination:CLLocationCoordinate2D = currentPlacemark.location.coordinate
        
        locationManager.requestWhenInUseAuthorization()
        NSLog("Requesting auth inside showDirections")
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 25
        locationManager.startUpdatingLocation()
        
        NSLog("\(locationManager.description)")
        self.currentLatitude = locationManager.location.coordinate.latitude
        self.currentLongitude = locationManager.location.coordinate.longitude
        
        var currentLocation = locationManager.location.coordinate
        var sourcePlacemark:MKPlacemark = MKPlacemark(coordinate: currentLocation, addressDictionary: nil)
        var destPlacemark:MKPlacemark = MKPlacemark(coordinate: CLLocationCoordinate2DMake(destLat, destLon), addressDictionary: nil)
        
        var sourceMapItem:MKMapItem = MKMapItem(placemark: sourcePlacemark)
        var destMapItem:MKMapItem = MKMapItem(placemark: destPlacemark)
        
        var dirReq:MKDirectionsRequest = MKDirectionsRequest()
        
        dirReq.setSource(sourceMapItem)
        dirReq.setDestination(destMapItem)
        dirReq.transportType = MKDirectionsTransportType.Automobile
        dirReq.requestsAlternateRoutes = true
        
        var directions:MKDirections = MKDirections(request: dirReq)
        directions.calculateDirectionsWithCompletionHandler({
            (response: MKDirectionsResponse!, error: NSError?) in
            if error != nil {
                NSLog("Error")
            }
            if response != nil{
                NSLog(response.description)
            }
            else {
                NSLog("No Response")
            }
        })
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        if locations != nil {
            var currentLocation:CLLocation = locations.last as CLLocation
            currentLatitude = currentLocation.coordinate.latitude
            currentLongitude = currentLocation.coordinate.longitude
        }
    }

    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        NSLog("Error")
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
