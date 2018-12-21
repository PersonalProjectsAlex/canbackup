//
//  DatePopup.swift
//  CanLove
//
//  Created by Alex on 31/10/18.
//  Copyright © 2018 Techlatam. All rights reserved.
//

import UIKit

class DatePopup: UIViewController {
    
    // MARK: - Let-Var
    let locale = Locale(identifier: "es_GT")
    let dateFormatter = DateFormatter()
    
    // MARK: - Outlets
    @IBOutlet weak var timePicker: UIDatePicker!{
        didSet {
            var sevenDaysfromNow: Date {
                return (Calendar.current as NSCalendar).date(byAdding: .day, value: 0, to: Date(), options: [])!
            }
            
            timePicker.maximumDate = sevenDaysfromNow
            timePicker.locale = locale
            timePicker.setValue(#colorLiteral(red: 0.1373712122, green: 0.345433712, blue: 0.4244714379, alpha: 1), forKey: "textColor")
            timePicker.datePickerMode = .date
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.locale = locale
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        dateFormatter.dateFormat = "dd MMMM yyyy"
        let date = dateFormatter.string(from: timePicker.date)
        Singleton.shared.setDate(date)
        
        
    }
    
    @IBAction func timepickerChanged(_ sender: UIDatePicker) {
        dateFormatter.dateFormat = "dd MMMM yyyy"
        let date = dateFormatter.string(from: timePicker.date)
        Singleton.shared.setDate(date)
        
    }
    
    
    
}
