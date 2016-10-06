//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Parthasarathy, Madhu on 9/23/16.
//  Copyright © 2016 Parthasarathy, Madhu. All rights reserved.
//

import UIKit

class RatingControl: UIView {
    // MARK: Properties
    var rating = 0 {
        didSet {
            // trigger a layout update every time the rating changes
            setNeedsLayout()
        }
    }
    var ratingButtons = [UIButton]()
    let spacing = 5
    let starCount = 5

    // MARK: Initializer
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let filledStarImage = UIImage(named: "filledStar")
        let emptyStartImage = UIImage(named: "emptyStar")
        
        
        for _ in 0..<starCount {
            let button = UIButton()
            button.setImage(emptyStartImage, for: .normal)
            button.setImage(filledStarImage, for: .selected)
            // filled star for when the user is in the process of tapping the button
            button.setImage(filledStarImage, for: [.highlighted, .selected])
            // ensure that the image does not show an additional highlight during state change
            button.adjustsImageWhenHighlighted = false
            
            button.addTarget(self, action: #selector(RatingControl.ratingButtonPressed(_:)), for: .touchDown)
            ratingButtons += [button]
            addSubview(button)
        }
    }
    
    override func layoutSubviews() {
        // Set the button's width and height to a square the size of the frame's height. The frame is that of the container of this view
        let buttonSize = Int(frame.size.height)
        var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        
        // Offset each button's origin by the length of the button plus some spacing.
        for (index, button) in ratingButtons.enumerated() {
            buttonFrame.origin.x = CGFloat(index * (buttonSize + spacing))
            button.frame = buttonFrame
        }
        
        updateButtonSelectionStates()
    }
    
    override var intrinsicContentSize: CGSize {
        self.invalidateIntrinsicContentSize();
        let buttonSize = 44 // Int(frame.size.height) is NOT working
        // the width of this control depends on the number of stars and the spacing between them
        let w = (buttonSize * starCount) + (spacing * (starCount - 1))
        
        return CGSize(width: w, height: buttonSize)
    }
    
    // MARK: Action
    func ratingButtonPressed(_ button: UIButton) {
        rating = ratingButtons.index(of: button)! + 1
        updateButtonSelectionStates()
    }
    
    func updateButtonSelectionStates() {
        for(index, button) in ratingButtons.enumerated() {
            // if the index is less than the rating, that button should be selected
            button.isSelected = index < rating
        }
    }
    
}
