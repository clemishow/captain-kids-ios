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
    
}
