//
//  MealViewController.swift
//  FoodTracker
//
//  Created by Parthasarathy, Madhu on 9/21/16.
//  Copyright © 2016 Parthasarathy, Madhu. All rights reserved.
//

import UIKit

class MealViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        // Depending on the style of presentation (modal or push), different actions are required.
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        // if the view controller that is presenting is it's own navigation controller, then the presentation style is modal (this is because the view controller in push style presentations would be part of the main navigation controller's stack)
        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)
            return
        }
        navigationController!.popViewController(animated: true)
    }
    
    var meal: Meal!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // handle the text fields' user input through delegate callbacks
        nameTextField.delegate = self
        
        // set up view correctly if updating an existing meal
        if let mealFromTable = meal {
            navigationItem.title = mealFromTable.name
            nameTextField.text = mealFromTable.name
            photoImageView.image = mealFromTable.photo
            ratingControl.rating = mealFromTable.rating
        }
        
        // enable the save button only if text field has a valid meal name
        checkValidMealName()
    }
    
    // MARK: UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isEnabled = false
    }
    
    func checkValidMealName() {
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide keyboard
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        checkValidMealName()
        navigationItem.title = textField.text
    }
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // dismiss picker if user cancelled
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // Info dictionary contains multiple representations of the image. Use the original
        let selectedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        photoImageView.image = selectedImage
        // dismiss the picker
        dismiss(animated: true, completion: nil)
    }

    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if saveButton === (sender as? UIBarButtonItem) {
            let name = nameTextField.text ?? ""
            let rating = ratingControl.rating
            let photo = photoImageView.image
            // set meal with data obtained from the UI and that will be passed to MealTableViewController after the unwind segue
            meal = Meal(name: name, rating: rating, photo: photo)
        }
    }
    
    // MARK: Actions
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        // hide the keyboard when user taps on photo will typing in text field
        nameTextField.resignFirstResponder()
        // UIImagePickerController is a view controller that lets user pick media from their photo library.
        let imagePickerCtrl = UIImagePickerController()
        // Only allow photos to be picked, not taken.
        imagePickerCtrl.sourceType = .photoLibrary
        // Make sure ViewController is notified when the user picks an image.
        imagePickerCtrl.delegate = self
        present(imagePickerCtrl, animated: true, completion: nil)
    }
}

