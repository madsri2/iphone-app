//
//  Meal.swift
//  FoodTracker
//
//  Created by Parthasarathy, Madhu on 9/28/16.
//  Copyright © 2016 Parthasarathy, Madhu. All rights reserved.
//

import UIKit

class Meal: NSObject, NSCoding {
    // MARK: Types
    struct PropertyKey {
        static let nameKey = "name"
        static let nameRating = "rating"
        static let namePhoto = "photo"
    }
    
    // MARK: Properties
    var name: String
    var rating: Int
    var photo: UIImage?
    
    static var DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("meals")
    
    // MARK: Initialization
    init?(name: String, rating: Int, photo: UIImage?) {
        self.name = name
        self.rating = rating
        self.photo = photo
        
        // validate input
        if name.isEmpty || (rating < 0) {
            return nil
        }
        
        // This is a designated initializer, so it needs to call the super's init method
        super.init()
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: PropertyKey.nameKey) as! String
        // Because photo is an optional property of Meal, use conditional cast.
        let photo = aDecoder.decodeObject(forKey: PropertyKey.namePhoto) as? UIImage
        let rating = aDecoder.decodeInteger(forKey: PropertyKey.nameRating)
        
        // call designated constructor
        self.init(name: name, rating: rating, photo: photo)
    }
    
    // MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.nameKey)
        aCoder.encode(photo, forKey: PropertyKey.namePhoto)
        aCoder.encode(rating, forKey: PropertyKey.nameRating)
    }
    
}
