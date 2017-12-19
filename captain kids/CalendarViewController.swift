//
//  CalendarViewController.swift
//  captain kids
//
//  Created by Dev on 19/12/2017.
//  Copyright © 2017 Hetic. All rights reserved.
//

import UIKit
import FSCalendar


class CalendarViewController: UIViewController, FSCalendarDataSource, FSCalendarDelegate {
    
    
    @IBOutlet weak var calendar: FSCalendar!
    var selectDate: Date? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date) {
        self.selectDate = date
    }
    
    @IBAction func handleValidate(_ sender: UIButton) {
        print("tapped")
        
        print(selectDate)
        if (selectDate != nil) {
            print("there is a selected date")
        } else {
            print("no select date")
            let alert = UIAlertController(title: "Erreur", message: "Veuillez sélectionner une date", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
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
