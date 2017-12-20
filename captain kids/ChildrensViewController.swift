//
//  ChildrensViewController.swift
//  captain kids
//
//  Created by Dev on 19/12/2017.
//  Copyright © 2017 Hetic. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ChildrensViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var selectDate: Date?
    var ref: DatabaseReference!
    var list = [Children]()
    var selectedChildrens: [Children] = []
    // Loading part
    let loadingView = UIView()
    let spinner = UIActivityIndicatorView()
    let loadingLabel = UILabel()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        setLoadingScreen()
        
        self.getChildrens()
        
        print(selectDate)
        
        tableView.allowsMultipleSelection = true
    }
    
    func getChildrens() {
        self.ref.child("childrens").observeSingleEvent(of: .value, with: { (snapshot) in
            let values = snapshot.value as! [[String: Any]]
            
            for myJson in values {
                let lat = myJson["lat"] as? Double
                let lng = myJson["lng"] as? Double
                let name = myJson["name"] as? String
                let male = myJson["male"] as? Bool
                
                let newChildren = Children(name: name, lat: lat, lng: lng, male: male)
                self.list.append(newChildren)
            }
            print(self.list)
            print(self.list.count)
            self.tableView.reloadData()
            self.removeLoadingScreen()
        }) { (error) in
            print(error.localizedDescription)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(self.list.count)
        return(list.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = list[indexPath.row].name
        
        return(cell)
    }
    
    @IBAction func handleValidate(_ sender: UIButton) {
        let selectedChildrens = self.tableView.indexPathsForSelectedRows?.map { list[$0.row] }
        print(selectedChildrens)
        if selectedChildrens != nil {
            print("chidrens")
        } else {
            print("no children selected")
        }
    }
    
    private func setLoadingScreen() {
        // Sets the view which contains the loading text and the spinner
        let width: CGFloat = 120
        let height: CGFloat = 30
        let x = (tableView.frame.width / 2) - (width / 2)
        let y = (tableView.frame.height / 2) - (height / 2) - (navigationController?.navigationBar.frame.height)!
        loadingView.frame = CGRect(x: x, y: y, width: width, height: height)
        
        // Sets loading text
        loadingLabel.textColor = .gray
        loadingLabel.textAlignment = .center
        loadingLabel.text = "Chargement..."
        loadingLabel.frame = CGRect(x: 0, y: 0, width: 140, height: 30)
        
        // Sets spinner
        spinner.activityIndicatorViewStyle = .gray
        spinner.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        spinner.startAnimating()
        
        // Adds text and spinner to the view
        loadingView.addSubview(spinner)
        loadingView.addSubview(loadingLabel)
        
        tableView.addSubview(loadingView)
    }
    
    private func removeLoadingScreen() {
        // Hides and stops the text and the spinner
        spinner.stopAnimating()
        spinner.isHidden = true
        loadingLabel.isHidden = true
    }
}
