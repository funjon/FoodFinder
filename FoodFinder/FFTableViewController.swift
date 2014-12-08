//
//  FoodFinderTableViewController.swift
//  FoodFinder
//
//  Created by Jonathan Disher on 12/8/14.
//  Copyright (c) 2014 Jonathan Disher. All rights reserved.
//

import UIKit
import MapKit

class FFTableViewController: UITableViewController {
    
    // Array of Restaurants
    var restaurantArray = [RestaurantItem]()
    
    // Count of restaurants
    var restaurantCount:Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        // Load the plist
        var path = NSBundle.mainBundle().pathForResource("restaurants", ofType: "plist")
        var dict = NSDictionary(contentsOfFile: path!)!
        
        // Get the count
        restaurantCount = dict.count;
        NSLog("Got \(restaurantCount) restaurants")
        
        // Populate objects
        var key:String
        for key in dict.allKeys {
            // Make a new restaurant object
            var rest = RestaurantItem()
            
            let entry = dict.objectForKey(key) as NSDictionary
            rest.setName(entry.objectForKey("name") as String)
            rest.setAddress(entry.objectForKey("address") as String)
            rest.setImage(entry.objectForKey("image") as String)
            
            // Add it to the array
            restaurantArray.append(rest)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantArray.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellID = "restaurantCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellID, forIndexPath: indexPath) as? RestaurantCell
        
        if (cell == nil) {
            cell = RestaurantCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellID)
        }

        // Configure the cell...
        NSLog("Building cell for \(restaurantArray[indexPath.row].name())")
        
        cell?.restaurantName.text = restaurantArray[indexPath.row].name()
        cell?.restaurantAddress.text = restaurantArray[indexPath.row].address()
        cell?.restaurantImage.image = UIImage(named: restaurantArray[indexPath.row].image())
        
        NSLog("Built cell for \(restaurantArray[indexPath.row].name)")
        
        return cell!
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "showRestaurant") {
            let indexPath = self.tableView.indexPathForSelectedRow()! as NSIndexPath
            var dvc = segue.destinationViewController as UINavigationController
            var mapViewController = dvc.viewControllers[0] as RestaurantMapViewController
            mapViewController.navRestaurant = restaurantArray[indexPath.row]
        }
    }

}
