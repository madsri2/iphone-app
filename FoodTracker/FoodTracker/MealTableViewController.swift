//
//  MealTableViewController.swift
//  FoodTracker
//
//  Created by Parthasarathy, Madhu on 9/28/16.
//  Copyright © 2016 Parthasarathy, Madhu. All rights reserved.
//

import UIKit

class MealTableViewController: UITableViewController {
    
    // MARK: Properties
    var meals = [Meal]()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // use edit button provided by the table view controller
        navigationItem.leftBarButtonItem = editButtonItem

        if let loadedMeals = loadMeals() {
            meals += loadedMeals
        }
        else {
            // first time loading this app, so there are no persisted meals. use the sample to see the list
            loadSampleMeals()
        }
        
    }
    
    func loadSampleMeals() {
        let meal1 = Meal(name: "Meal 1", rating: 4, photo: UIImage(named: "meal1"))!
        let meal2 = Meal(name: "Meal 2", rating: 3, photo: UIImage(named: "meal2"))!
        let meal3 = Meal(name: "Meal 3", rating: 5, photo: UIImage(named: "meal3"))!
        
        meals += [meal1, meal2, meal3]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    // Protocol functions of the table data source (UITableViewDataSource) that need to be overridden.
    override func numberOfSections(in tableView: UITableView) -> Int {
        // need only one section
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "MealTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MealTableViewCell

        // fetch the meal corresponding to the row
        let meal = meals[indexPath.row]
        
        cell.nameLabel.text = meal.name
        cell.photoImageView.image = meal.photo
        cell.ratingControl.rating = meal.rating

        return cell
    }
    
    // Unwinding from the "Your Meal" scene
    @IBAction func unwindToMealList(segue: UIStoryboardSegue) {
        if let sourceController = (segue.source as? MealViewController), let meal = sourceController.meal {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // update an existing meal
                meals[selectedIndexPath.row] = meal
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                // Add a new meal
                let newIndexPath = NSIndexPath(row: meals.count, section: 0)
                meals.append(meal)
                tableView.insertRows(at: [newIndexPath as IndexPath], with: .bottom)
            }
        }
        // persist the addition of a new meal or update of an existing meal
        saveMeals()
    }
    
    // MARK: Implement Edit functinoality

    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            meals.remove(at: indexPath.row)
            // persist deletes
            saveMeals()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    // ----> Method gets called before any segue gets executed. A Segue is a transition from one scene to another. 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            // Get the segue's destination view controller. From the sender cell (which will be a table cell), get the meal. Set the dest view controller's meal property to the meal object obtained from the sender cell.
            
            // perform a forced type cast. if the cast is successful, the app will CRASH at runtime!
            let mealDetailViewController = segue.destination as! MealViewController
            
            if let selectedMealCell = sender as? MealTableViewCell {
                let indexPath = tableView.indexPath(for: selectedMealCell)!
                let selectedMeal = meals[indexPath.row]
                mealDetailViewController.meal = selectedMeal               
            }
        }
        
        if segue.identifier == "AddItem" {
                print("Adding a new meal")
        }
    }
    
    // MARK: NSCoding
    func saveMeals() {
        let successfullySaved = NSKeyedArchiver.archiveRootObject(meals, toFile: Meal.ArchiveURL.path)
        if !successfullySaved {
            print("Failed to save meals")
        }
    }
    
    func loadMeals() -> [Meal]? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Meal.ArchiveURL.path) as? [Meal]
    }
}
