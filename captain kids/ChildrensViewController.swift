//
//  ChildrensViewController.swift
//  captain kids
//
//  Created by Dev on 19/12/2017.
//  Copyright © 2017 Hetic. All rights reserved.
//

import UIKit

class ChildrensViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var selectDate: Date?
    var list: [Children] = [
        Children(name: "John", lat: 1.342424, lng: 2.4242552, male: true),
        Children(name: "Emma", lat: 1.342424, lng: 2.4242552, male: true),
        Children(name: "Marie", lat: 1.342424, lng: 2.4242552, male: true),
        Children(name: "Roxane", lat: 1.342424, lng: 2.4242552, male: true),
        Children(name: "Jean", lat: 1.342424, lng: 2.4242552, male: true)
    ]
    var selectedChildrens: [Children] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(selectDate)
        
        tableView.allowsMultipleSelection = true
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(list.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.text = list[indexPath.row].name
        
        return(cell)
    }
    
    @IBAction func handleValidate(_ sender: UIButton) {
        print(self.tableView.indexPathsForSelectedRows?.map { list[$0.row] })
    }
}
