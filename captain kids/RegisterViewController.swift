//
//  RegisterViewController.swift
//  captain kids
//
//  Created by Dev on 18/12/2017.
//  Copyright © 2017 Hetic. All rights reserved.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        // Register with Firebase
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                
                // Create alert
                let alertController = UIAlertController(title: "Erreur", message:
                    "", preferredStyle: UIAlertControllerStyle.alert)
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default,handler: nil))
                
                if let u = user {
                    // Work
                    alertController.title = "Compte crée"
                    alertController.message = "Votre compte a bien été crée. Vous pouvez désormais vous connecter"
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    // Error
                    // Get code error from Firebase Auth
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
        }
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
