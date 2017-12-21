//
//  BackgroundGradient.swift
//  captain kids
//
//  Created by Dev on 21/12/2017.
//  Copyright © 2017 Hetic. All rights reserved.
//

import Foundation
import UIKit

class BackgroundGradient {
    static func initialize(view: UIView) {
        // Background gradient
        let colorTop =  UIColor(red: 138/255, green: 233/255, blue: 172/255, alpha: 1).cgColor
        let colorBottom = UIColor(red: 35/255, green: 205/255, blue: 230/255.0, alpha: 1).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [ colorTop, colorBottom]
        gradientLayer.locations = [ 0.0, 1.0]
        gradientLayer.frame = view.bounds
        
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}

