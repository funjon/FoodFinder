//
//  RestaurantItem.swift
//  FoodFinder
//
//  Created by Jonathan Disher on 12/8/14.
//  Copyright (c) 2014 Jonathan Disher. All rights reserved.
//

import UIKit

class RestaurantItem: NSObject {
    // Attributes with inits
    var _restaurantName:String    = ""
    var _restaurantAddress:String = ""
    var _restaurantImage:String   = ""
    
    // Setters
    func setName(name:String)       { _restaurantName = name }
    func setAddress(address:String) { _restaurantAddress = address }
    func setImage(image:String)     { _restaurantImage = image }
    
    // Getters
    func name()    -> String { return _restaurantName }
    func address() -> String { return _restaurantAddress }
    func image()   -> String { return _restaurantImage }
   
}
