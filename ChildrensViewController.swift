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
        
        self.title = "Choissiez les enfants"
        
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
        if list[indexPath.row].male == true {
            cell.imageView?.image = UIImage(named: "avatar-boy")
        } else {
            cell.imageView?.image = UIImage(named: "avatar-girl")
        }
        cell.textLabel?.text = list[indexPath.row].name
        cell.detailTextLabel?.text = "Hello"
        cell.backgroundColor = UIColor.clear
        cell.layer.masksToBounds = true
        cell.selectionStyle = .none
        cell.layer.borderColor = UIColor( red: 246/255, green: 246/255, blue: 245/255, alpha: 1).cgColor
        cell.layer.borderWidth = 2.0
        return(cell)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! UITableViewCell
        
        cell.imageView?.image = UIImage(named: "avatar-validate")
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! UITableViewCell
        if list[indexPath.row].male == true {
            cell.imageView?.image = UIImage(named: "avatar-boy")
        } else {
            cell.imageView?.image = UIImage(named: "avatar-girl")
        }
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if let selectedRows = tableView.indexPathsForSelectedRows?.filter({ $0.section == indexPath.section }) {
            if selectedRows.count > 3 {
                let alert = UIAlertController(title: "Erreur", message: "Vous ne pouvez pas prendre plus de 4 enfants en charge", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return nil
            }
        }
        return indexPath
    }
    
    @IBAction func handleValidate(_ sender: UIButton) {
        let selectedChildrens = self.tableView.indexPathsForSelectedRows?.map { list[$0.row] }
        print(selectedChildrens)
        if selectedChildrens != nil {
            let controller = storyboard?.instantiateViewController(withIdentifier: "ConfirmationViewController") as! ConfirmationViewController
            controller.selectDate = self.selectDate
            controller.selectedChildrens = selectedChildrens
            navigationController?.pushViewController(controller, animated: true)
        } else {
            let alert = UIAlertController(title: "Erreur", message: "Veuillez sélectionner au moins un enfant", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    private func setLoadingScreen() {
        // Sets the view which contains the loading text and the spinner
        let width: CGFloat = 120
        let height: CGFloat = 30
        let x = (tableView.frame.width / 2) - (width / 2)
        let y = (tableView.frame.height / 2) - (height / 2) - (navigationController?.navigationBar.frame.height)!
        loadingView.frame = CGRect(x: x, y: y, width: width, height: height)
        
        // Background UITableView
        self.tableView.isHidden = true
        
        // Sets loading text
        loadingLabel.textColor = .gray
        loadingLabel.textAlignment = .center
        loadingLabel.text = "Chargement..."
        loadingLabel.frame = CGRect(x: 0, y: 0, width: 180, height: 30)
        
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
        // Background UITableView
        self.tableView.isHidden = false
    }
}
