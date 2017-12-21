//
//  HomeViewController.swift
//  captain kids
//
//  Created by Dev on 18/12/2017.
//  Copyright © 2017 Hetic. All rights reserved.
//

import UIKit
import FirebaseAnalytics
import FirebaseAuth
import FirebaseDatabase

class HomeViewController: UIViewController {

    @IBOutlet weak var beAccompagnyButton: UIButton!
    @IBOutlet weak var toAccompagnyButton: UIButton!
    @IBOutlet weak var displayNameLabel: UILabel!
    var ref: DatabaseReference!
    @IBOutlet weak var profileImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        ref = Database.database().reference()
        
        self.getAPI()
        
        // Circle image profile
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2
        profileImageView.clipsToBounds = true
        profileImageView.layer.borderWidth = 2
        profileImageView.layer.borderColor = UIColor(red: 10/255, green: 197/255, blue: 211/255, alpha: 1.0).cgColor
        toAccompagnyButton.setTitleColor(Color.blue(), for: .normal)
        beAccompagnyButton.setTitleColor(Color.blue(), for: .normal)
    
        Button.addBorderTop(button: toAccompagnyButton)
        Button.addBorderTop(button: beAccompagnyButton)
        Button.addBorderBottom(button: beAccompagnyButton)
    }
    
    func getAPI() {
        let user = Auth.auth().currentUser
        
        if user != nil {
            displayNameLabel.text = "Bonjour " + user!.displayName!
            ref.child("picking").child(user!.uid).observeSingleEvent(of: .value, with: { (snapshot) in
                print(snapshot)
                if snapshot.exists() {
                    if let result = snapshot.children.allObjects as? [DataSnapshot] {
                        for child in result {
                            let id = child.key
                            print(id)
                        }
                    }
                } else {
                    print("no date")
                }
                
            }) { (error) in
                print(error.localizedDescription)
            }
        } else {
            print("no user sign in")
        }
    }
    
    @IBAction func toAccompagny(_ sender: UIButton) {
        // Firebase event button choice
        Analytics.logEvent("select_usage", parameters: [
            "usage_type": "être accompagnateur"
        ])
    }
    
    @IBAction func beAccompagny(_ sender: UIButton) {
        Analytics.logEvent("select_usage", parameters: [
            "select_type": "faire raccompagner"
        ])
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
