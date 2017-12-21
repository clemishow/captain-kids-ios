//
//  ConfirmationViewController.swift
//  captain kids
//
//  Created by Dev on 20/12/2017.
//  Copyright © 2017 Hetic. All rights reserved.
//

import UIKit
import MapKit
import FirebaseDatabase
import FirebaseAuth
import FirebaseAnalytics

class ConfirmationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var selectedChildrens: [Children]!
    var selectDate: Date?
    var ref: DatabaseReference!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.allowsSelection = false
        self.title = "Récapitulatif"
        
        self.initMap()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initMap() {
        let span = MKCoordinateSpanMake(0.02, 0.02)
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 48.852626, longitude: 2.369311), span: span)
        mapView.setRegion(region, animated: true)
        
        self.createMarkers()
    }
    
    func createMarkers() {
        var annotations: [MKAnnotation] = []
        for children in selectedChildrens {
            print(children)
            let annotation = MKPointAnnotation()
            annotation.title = children.name!
            annotation.coordinate = CLLocationCoordinate2D(latitude: children.lat!, longitude: children.lng!)
            mapView.addAnnotation(annotation)
            annotations.append(annotation)
        }
        mapView.showAnnotations(annotations, animated: true)
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(selectedChildrens!.count)
        return selectedChildrens!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = selectedChildrens![indexPath.row].name
        cell.backgroundColor = UIColor.clear
        
        return(cell)
    }
    
    // Post data of user selection (date + list)
    func postPicking() {
        ref = Database.database().reference()
        let user = Auth.auth().currentUser
        
        // Firebase event number of childrens choosen
        Analytics.logEvent("selected_childrens", parameters: [
            "number": selectedChildrens.count
        ])
        
        if let user = user {
            
            var pickingData = [[String: Any]]()
            
            
            for children in selectedChildrens {
                let data: [String: Any] = [
                    "name": children.name!,
                    "lat": children.lat!,
                    "lng": children.lng!,
                    "male": children.male!
                ]
                pickingData.append(data)
            }
            
            // Format date to string
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            
            pickingData.append(["date": formatter.string(from: selectDate!)])
            
            print(pickingData)
            self.ref.child("picking").child(user.uid).childByAutoId().setValue(pickingData) { err, ref in
                print("done")
                self.performSegue(withIdentifier: "goBackToHome", sender: self)
            }
        }
    }
    
    @IBAction func handleValidate(_ sender: UIButton) {
        self.postPicking()
    }
    
}
