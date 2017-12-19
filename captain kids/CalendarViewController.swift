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
        
        calendar.today = nil
        print(Date())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // When user select a date
    func calendar(_ calendar: FSCalendar, didSelect date: Date) {
        self.selectDate = Calendar.current.date(byAdding: .day, value: 1, to: date)
    }
    
    // When user tap validate button
    @IBAction func handleValidate(_ sender: UIButton) {
        if (selectDate != nil) {
            print("there is a selected date")
            let controller = storyboard?.instantiateViewController(withIdentifier: "ChildrensViewController") as! ChildrensViewController
            controller.selectDate = self.selectDate
            navigationController?.pushViewController(controller, animated: true)
        } else {
            let alert = UIAlertController(title: "Erreur", message: "Veuillez sélectionner une date", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func minimumDate(for calendar: FSCalendar) -> Date {
        return Date()
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
