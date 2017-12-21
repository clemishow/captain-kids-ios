//
//  Button.swift
//  captain kids
//
//  Created by Dev on 21/12/2017.
//  Copyright © 2017 Hetic. All rights reserved.
//

import Foundation
import UIKit

class Button {
    
    static func whiteRounded(button: UIButton) {
        button.setTitle(button.titleLabel!.text?.uppercased(), for: .normal)
        button.backgroundColor = UIColor.white
        button.setTitleColor(Color.blue(), for: .normal)
        button.frame.size.height = 80
        button.frame.size.width = 300
        button.layer.cornerRadius = 25
        button.clipsToBounds = true
    }
    
    static func underlineButton(text: String, button: UIButton, color: UIColor) {
        let titleString = NSMutableAttributedString(string: text)
        titleString.addAttribute(NSAttributedStringKey.underlineStyle, value: NSUnderlineStyle.styleSingle.rawValue, range: NSMakeRange(0, text.characters.count))
        titleString.addAttribute(NSAttributedStringKey.foregroundColor, value: color, range: NSMakeRange(0, text.characters.count))
        button.setAttributedTitle(titleString, for:
            .normal)
    }
    
}
