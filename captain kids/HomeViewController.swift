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
        
    }
    
    func getAPI() {
        let user = Auth.auth().currentUser
        if user != nil {
            print("user sign in")
            print(user!)
            print(user!.email!)
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
