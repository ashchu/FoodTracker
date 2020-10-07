//
//  RatingControl.swift
//  FoodTracker
//
//  Created by Ashley Chu on 10/7/20.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    //mark: properties
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet {
            setUpButtons()
        }
    }
    @IBInspectable var starCount: Int = 5 {
        didSet {
            setUpButtons()
        }
    }
    private var ratingButtons = [UIButton]()
    var rating = 0 {
        didSet{
            updateButtonSelectionStates()
        }
    }
    
    //Mark: Initialization
    override init(frame: CGRect) {
        //calls over from superclass
        super.init(frame: frame)
        setUpButtons()
    }
    
    required init(coder: NSCoder) {
        //calls over from superclass
        super.init(coder: coder)
        setUpButtons()
    }
    
    //Mark: Private Methods
    private func setUpButtons(){
        
        let bundle = Bundle(for: type(of: self))
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        let emptyStar = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(named: "highlightedStar", in: bundle, compatibleWith: self.traitCollection)
        
        for b in ratingButtons {
            removeArrangedSubview(b)
            b.removeFromSuperview()
        }
        
        ratingButtons.removeAll()
        
        for _ in 0..<starCount {
            //create button
            let button = UIButton()
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            
            //constraints
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            //accessibility label
            button.accessibilityLabel = "Set star rating"
            
            //setup action
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)

            
            //adds button to stack
            addArrangedSubview(button)
            
            ratingButtons.append(button)
        }
        
        updateButtonSelectionStates()
    }
    
    @objc func ratingButtonTapped(button: UIButton){
        guard let index = ratingButtons.firstIndex(of: button) else {
            fatalError("Button \(button) is not in the ratingButtons array: \(ratingButtons)")
        }
        
//        Calculate rating of selected button
        let selectedRating = index+1
        
        if selectedRating == rating {
            //if selected star reps current rating, reset to 0
            rating = 0
        } else {
            rating = selectedRating
        }
        
    }

    private func updateButtonSelectionStates(){
        for(index, button) in ratingButtons.enumerated() {
            button.isSelected = index < rating
            
            // Set the hint string for the currently selected star
            let hintString: String?
            if rating == index + 1 {
                hintString = "Tap to reset the rating to zero."
            } else {
                hintString = nil
            }
             
            // Calculate the value string
            let valueString: String
            switch (rating) {
            case 0:
                valueString = "No rating set."
            case 1:
                valueString = "1 star set."
            default:
                valueString = "\(rating) stars set."
            }
             
            // Assign the hint string and value string
            button.accessibilityHint = hintString
            button.accessibilityValue = valueString
        }
    }
}
