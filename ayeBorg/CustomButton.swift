//
//  CustomButton.swift
//  myDadBorg
//
//  Created by Ira Theobold on 19/03/2020.
//  Copyright © 2020 Ira Theobold. All rights reserved.
//

import UIKit

class CustomButton: UIButton {
    

    override open var isHighlighted: Bool {
        didSet {
            let buttonColour = [UIColor.systemRed,
                                UIColor.systemBlue,
                                UIColor.systemGreen,
                                UIColor.systemYellow,
                                UIColor.systemPink,
                                UIColor.systemOrange,
                                UIColor.systemIndigo,
                                UIColor.systemPurple
                                ]
            let randomColour = buttonColour.randomElement()
            
            backgroundColor = isHighlighted ? randomColour : UIColor.systemTeal
        }
    }

}
