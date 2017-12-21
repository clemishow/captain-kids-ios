//
//  TextField.swift
//  captain kids
//
//  Created by Dev on 21/12/2017.
//  Copyright © 2017 Hetic. All rights reserved.
//

import Foundation
import UIKit

class TextFieldCustom {
    
    static func initialize(textField: UITextField) {
        let border = CALayer()
        let width = CGFloat(2)
        border.borderColor = UIColor.white.cgColor
        border.frame = CGRect(x: 1, y: textField.frame.size.height - width, width:  textField.frame.size.width, height: textField.frame.size.height)
        
        border.borderWidth = width
        textField.backgroundColor = .clear
        textField.borderStyle = .none
        textField.textColor = UIColor.white
        textField.layer.addSublayer(border)
        textField.layer.masksToBounds = true
    }
    
}
