//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by Parthasarathy, Madhu on 9/21/16.
//  Copyright © 2016 Parthasarathy, Madhu. All rights reserved.
//

import XCTest
@testable import FoodTracker

class FoodTrackerTests: XCTestCase {
    
    // MARK: FoodTracker tests
    
    
    func testMealInitialization() {
        // success cases
        let firstMeal = Meal(name: "First meal", rating: 1, photo: nil)
        XCTAssertNotNil(firstMeal)
        
        // failure cases
        let noName = Meal(name: "", rating: 0, photo: nil)
        XCTAssertNil(noName, "Empty name is invalid")
        
        let badRating = Meal(name: "First Meal", rating: -1, photo: nil)
        XCTAssertNil(badRating, "Negative ratings are invalid")
        
        
    }
    

}
