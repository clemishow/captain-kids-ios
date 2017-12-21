//
//  ViewController.swift
//  captain kids
//
//  Created by Dev on 18/12/2017.
//  Copyright © 2017 Hetic. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseAnalytics

class ViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var connexionUIButton: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordTextField.delegate = self
        emailTextField.delegate = self
        
        BackgroundGradient.initialize(view: self.view)
        
        Button.whiteRounded(button: connexionUIButton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func viewDidLayoutSubviews() {
        TextFieldCustom.initialize(textField: emailTextField)
        TextFieldCustom.initialize(textField: passwordTextField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        passwordTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
        return true
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func signinButtonTapped(_ sender: UIButton) {
        // Sign in with Firebase
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                
                // Create alert
                let alertController = UIAlertController(title: "Erreur", message:
                    "", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
                
                if let u = user {
                    // Firebase event register successfully
                    Analytics.logEvent("login", parameters: nil)
                    
                    // Work
                    self.performSegue(withIdentifier: "goToHomePage", sender: self)
                } else {
                    // Error
                    // Get code error from Firebase Auth
                    if let errCode = AuthErrorCode(rawValue: error!._code) {
                        switch errCode {
                        case .invalidEmail:
                            alertController.message = "L'email n'est pas valide"
                        case .networkError:
                            alertController.message = "Un problème de connexion est survenu"
                        case .wrongPassword:
                            alertController.message = "Le mot de passe est invalide"
                        case .userNotFound:
                            alertController.message = "Il n'y a pas d'utilisateur qui correspond à cet identifiant"
                        default:
                            print("Other error!")
                            alertController.message = "Une erreur est survenue, si elle persiste, contactez-nous"
                    }
                        self.present(alertController, animated: true, completion: nil)
                    }
                }
            })
        } else {
            // Fields empty
        }
    }
}

