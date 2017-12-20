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

extension Array {
    public func toDictionary<Key: Hashable>(with selectKey: (Element) -> Key) -> [Key:Element] {
        var dict = [Key:Element]()
        for element in self {
            dict[selectKey(element)] = element
        }
        return dict
    }
}


class ConfirmationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var selectedChildrens: [Children]!
    var selectDate: Date?
    var ref: DatabaseReference!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(selectDate)
        print(selectedChildrens)
        self.tableView.allowsSelection = false
        self.title = "Récapitulatif"
        
        self.initMap()
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(selectedChildrens!.count)
        return selectedChildrens!.count
    }
    
    func postPicking() {
        ref = Database.database().reference()
        let user = Auth.auth().currentUser
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = selectedChildrens![indexPath.row].name
        cell.backgroundColor = UIColor.clear
        
        return(cell)
    }
    
    @IBAction func handleValidate(_ sender: UIButton) {
        self.postPicking()
    }
    
}
