//
//  ConfirmationViewController.swift
//  captain kids
//
//  Created by Dev on 20/12/2017.
//  Copyright © 2017 Hetic. All rights reserved.
//

import UIKit

class ConfirmationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var selectedChildrens: [Children]?
    var selectDate: Date?

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(selectDate)
        print(selectedChildrens)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(selectedChildrens?.count)
        return selectedChildrens!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = selectedChildrens![indexPath.row].name
        cell.backgroundColor = UIColor.clear
        
        return(cell)
    }
    
    
    

  

}
