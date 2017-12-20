//
//  ConfirmationViewController.swift
//  captain kids
//
//  Created by Dev on 20/12/2017.
//  Copyright © 2017 Hetic. All rights reserved.
//

import UIKit
import MapKit

class ConfirmationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var selectedChildrens: [Children]?
    var selectDate: Date?
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
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = CLLocationCoordinate2D(latitude: 48.864682, longitude: 2.354719)
        mapView.addAnnotation(annotation)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    
}
