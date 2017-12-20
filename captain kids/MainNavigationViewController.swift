//
//  MainNavigationViewController.swift
//  captain kids
//
//  Created by Dev on 20/12/2017.
//  Copyright © 2017 Hetic. All rights reserved.
//

import UIKit

class MainNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.barTintColor = UIColor(red: 10/255, green: 197/255, blue: 211/255, alpha: 1)
        navigationBar.tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        UIApplication.shared.statusBarStyle = .lightContent
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
