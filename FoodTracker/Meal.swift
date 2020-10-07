//
//  Meal.swift
//  FoodTracker
//
//  Created by Ashley Chu on 10/7/20.
//

import UIKit

class Meal {
    //init
    init?(name: String, photo: UIImage?, rating: Int) {
        
        // Initialization should fail if there is no name or if the rating is negative.
        if name.isEmpty || rating < 0  {
            return nil
        }
        
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.rating = rating
        
    }
    
    //MARK: Properties
    
    var name: String
    var photo: UIImage?
    var rating: Int
    
}
