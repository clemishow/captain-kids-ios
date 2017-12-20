//
//  HomeViewController.swift
//  captain kids
//
//  Created by Dev on 18/12/2017.
//  Copyright © 2017 Hetic. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class HomeViewController: UIViewController {

    @IBOutlet weak var displayNameLabel: UILabel!
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let user = Auth.auth().currentUser
        ref = Database.database().reference()
        
        
        
        if user != nil {
            print("user sign in")
            print(user!)
            print(user!.email!)
            displayNameLabel.text = "Bonjour " + user!.displayName!
            ref.child("picking").child(user!.uid).observeSingleEvent(of: .value, with: { (snapshot) in
                print(snapshot.value)
                if let result = snapshot.children.allObjects as? [DataSnapshot] {
                    for child in result {
                        var orderID = child.key as! String
                        print(orderID)
                    }
                }
               
            }) { (error) in
                print(error.localizedDescription)
            }
        } else {
            print("no user sign in")
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
