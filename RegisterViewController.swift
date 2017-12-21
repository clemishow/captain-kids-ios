//
//  RegisterViewController.swift
//  captain kids
//
//  Created by Dev on 18/12/2017.
//  Copyright © 2017 Hetic. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseAnalytics
import FirebaseDatabase

class RegisterViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var UIView: UIView!
    @IBOutlet weak var displayNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        displayNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        ageTextField.delegate = self
        
        BackgroundGradient.initialize(view: self.view)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == 1 {
            print("password")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        // Create alert
        let alertController = UIAlertController(title: "Erreur", message:
            "", preferredStyle: UIAlertControllerStyle.alert)
        
        // Register with Firebase
        if let email = emailTextField.text, !email.isEmpty,
           let password = passwordTextField.text, !password.isEmpty,
           let name = displayNameTextField.text, !name.isEmpty,
           let age = ageTextField.text, !age.isEmpty {
            Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                
                if let u = user {
                    // Work
                    alertController.title = "Compte crée"
                    alertController.message = "Votre compte a bien été crée. Vous pouvez désormais vous connecter"
                    
                    // Put age on Firebase database
                    print(age)
                    print(user!.uid)
                    
                    // Add a display name
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.displayName = name
                    changeRequest?.commitChanges { (error) in
                        print("error")
                        print(error)
                    }
                    
                    self.ref.child("users").child(user!.uid).setValue(["age": age])
                    
                    // Firebase event register successfully
                    Analytics.logEvent("register", parameters: [
                        "register_profile_type": "parent"
                    ])
                    
                    Analytics.setUserProperty(age, forName: "age")
                    
                    // Alert to handle redirection after register
                    alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {
                        (alert: UIAlertAction!) in self.performSegue(withIdentifier: "goToLoginPage", sender: self)
                    }))
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    // Error
                    // Get code error from Firebase Auth
                    alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    if let errCode = AuthErrorCode(rawValue: error!._code) {
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
        } else {
            alertController.title = "Erreur"
            alertController.message = "Veuillez remplir tous les champs"
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
