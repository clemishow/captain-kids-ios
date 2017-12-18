//
//  ViewController.swift
//  captain kids
//
//  Created by Dev on 18/12/2017.
//  Copyright © 2017 Hetic. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    
    @IBOutlet weak var signinButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var signinLabel: UILabel!
    @IBOutlet weak var signinSelector: UISegmentedControl!
    
    var isSignIn: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signinSelectorChanged(_ sender: UISegmentedControl) {
        // Flip boolean
        isSignIn = !isSignIn
        
        // Check the bool and set proper values
        if isSignIn {
            signinLabel.text = "Connexion"
            signinButton.setTitle("Connexion", for: .normal)
        } else {
            signinLabel.text = "S'inscrire"
            signinButton.setTitle("Sign In", for: .normal)
        }
    }
    
    @IBAction func signinButtonTapped(_ sender: UIButton) {
        // Validation fields
        print("tapped")

        if let email = emailTextField.text, let password = passwordTextField.text {
            print("there is value")
            if isSignIn {
                // Sign In user with Firebase
                Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                    print("sign in")
                    print(user)
                    print(error)
                    if let u = user {
                        // Work
                        self.performSegue(withIdentifier: "goToHome", sender: self)
                    } else {
                        // Error
                    }
                })
            } else {
                // Register with Firebase
                Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                    print("create user")
                    print(user)
                    print(error)
                    if let u = user {
                        // Work
                        self.performSegue(withIdentifier: "goToHome", sender: self)
                    } else {
                        // Error
                        // Get code error from Firebase Auth
                        if let errCode = AuthErrorCode(rawValue: error!._code) {
                            
                            // Create alert
                            let alertController = UIAlertController(title: "Erreur", message:
                                "", preferredStyle: UIAlertControllerStyle.alert)
                            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
                            
                            
                            switch errCode {
                                case .invalidEmail:
                                    alertController.message = "L'email n'est pas valide"
                                case .emailAlreadyInUse:
                                    alertController.message = "L'email est déjà utilisé"
                                case .weakPassword:
                                    alertController.message = "Le mot de passe doit comporter au moins 6 caractères"
                                case .networkError:
                                    alertController.message = "Un problème de connexion est survenu"
                                default:
                                    print("Other error!")
                                    alertController.message = "Une erreur est survenue, si elle persiste, contactez-nous"
                            }
                            self.present(alertController, animated: true, completion: nil)
                        }
                        
                    } 
                })
            }
        } else {
            // Fields empty
        }
    }
}

