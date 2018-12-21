//
//  ScheduledWalkthroughController.swift
//  CanLove
//
//  Created by Alex on 29/11/18.
//  Copyright © 2018 Techlatam. All rights reserved.
//

import UIKit
import DateTimePicker
import TagListView
import Alamofire

class ScheduledWalkthroughController: UIViewController,DateTimePickerDelegate {
    
    
    // MARK: - Let-Var
    //--Header
    open var header: HTTPHeaders{
        let token = Singleton.shared.checkValueSet(key: K.defaultKeys.auth.accessToken)
        let bearer = Core.shared.setBearerToken(token)
        return ["Authorization": bearer]
    }
    
    var myDogs = MyDogs()
    var selectedDog:MyDog?
    var dates = [scheduleDates]()
    let dateRow: DatesRow = UIView.fromNib()
    
    let locale = Locale(identifier: "es_GT")
    
     // MARK: - Outlets
    @IBOutlet weak var tagListView: TagListView!
    @IBOutlet weak var petsCollectionView: UICollectionView!
    //@IBOutlet weak var dateStackview: UIStackView!
    @IBOutlet weak var dateStackview: MyStackView!
    
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setting up general actions/delegates/Core
        setUpActions()
        
        // setting up UI elements to be used through the code
        setUpUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        gettingData()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
    
    // MARK: - SetUps / Funcs
    
    func setUpUI(){
        //Stackview
        dateStackview.distribution = .fillEqually
        dateStackview.spacing = 11
    }
    
    func setUpActions(){
        petsCollectionView.delegate = self
        petsCollectionView.dataSource = self
        
        //Set Cell Identifier
        Core.shared.registerCellCollection(at: petsCollectionView, named: K.cellsIdentifiers.collection.choosePetCollectionCell)

    }
    
    private func gettingData(){
        
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        myDogs.removeAll()
        
        DogManager().getDogs(header: header) {
            dogs in
            guard let dogs = dogs else{
                //weak.activityIndicator.stopAnimating()
                return
            }
            print(dogs)
            weak.myDogs = dogs
            
            if weak.myDogs.count > 0{
                weak.petsCollectionView.reloadData()
            }
        }
    }
    
    
    @IBAction func addAction(_ sender: UIButton) {
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        
        DispatchQueue.main.async {
            //weak.tagListHeight.constant = CGFloat(integerLiteral: 75)
            let picker = weak.setDateTimePicker()
            picker.show()
            
            picker.completionHandler = { date in
                let formatter = DateFormatter()
                formatter.locale = Locale.current
                formatter.dateFormat = "dd MMMM yyyy"
                let dateString = formatter.string(from: date)
                if let day = weak.transformStringDate(dateString, fromDateFormat:  "dd MMMM yyyy", toDateFormat: "dd"), let month = weak.transformStringDate(dateString, fromDateFormat:  "dd MMMM yyyy", toDateFormat: "MMMM") {
                    
                    weak.dates.append(scheduleDates(month: month, day: day))
                    weak.setDates()
                    
                }
            }
            
        }
    }
    
    
    func setDateTimePicker() -> DateTimePicker{
     
        let min = Date()
        let max = Date().addingTimeInterval(60 * 60 * 24 * 30)
        let picker = DateTimePicker.create(minimumDate: min, maximumDate: max)
        picker.locale = Locale.current
        picker.delegate = self
        picker.cancelButtonTitle = "Cancelar"
        picker.todayButtonTitle = "Ahora"
        picker.dateFormat = "dd MMMM yyyy"
        picker.is12HourFormat = true
        picker.highlightColor = #colorLiteral(red: 0.1373712122, green: 0.345433712, blue: 0.4244714379, alpha: 1)
        picker.doneBackgroundColor = #colorLiteral(red: 0.1373712122, green: 0.345433712, blue: 0.4244714379, alpha: 1)
        picker.doneButtonTitle = "Hecho"
        
        return picker
    }
    
    
    // MARK: - DateTimePicker
    func dateTimePicker(_ picker: DateTimePicker, didSelectDate: Date) {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "dd MMMM yyyy"
        let a = formatter.string(from: didSelectDate)
       
        
    }
    
    //Tranform dates
    func transformStringDate(_ dateString: String,
                             fromDateFormat: String,
                             toDateFormat: String) -> String? {
        
        let initalFormatter = DateFormatter()
        
        initalFormatter.dateFormat = fromDateFormat
        guard let initialDate = initalFormatter.date(from: dateString) else {
            print ("Error in dateString or in fromDateFormat")
            return nil
        }
        let resultFormatter = DateFormatter()
        resultFormatter.dateFormat = toDateFormat
        resultFormatter.locale = locale
        return resultFormatter.string(from: initialDate)
    }
    
    
    //Set dates
    func setDates(){
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        
        for view in weak.dateStackview.arrangedSubviews {
            weak.dateStackview.removeArrangedSubview(view)
            view.removeFromSuperview()
        }
        
        var datestack = [DatesRow]()
        
        dateRow.dates = dates
        
        
            for i in dateRow.dates{
            
                guard let lastMonth = weak.dates.last?.month else{return}
                dateRow.frame = CGRect(x: 0, y: 0, width: weak.view.frame.width, height: 30)
                datestack.append(dateRow)
                datestack.removeDuplicates()
                for a in datestack{
                    
                    weak.dateStackview.idArray.append(lastMonth)
                    weak.dateStackview.idArray.removeDuplicates()
                    
                    
                    dateRow.monthLabel.text = i.month
                    weak.dateStackview.id = i.month
                    
                    
                    for month in weak.dateStackview.idArray{
                        
                        if month == i.month{
                            var days = [String]()
                            days.append(i.day)
                            if i.month == lastMonth{
                                days.removeDuplicates()
                            }
                            dateRow.tagListView.addTags(days)
                            weak.dateStackview.addArrangedSubview(dateRow)
                        }
                        
                    }
                    
                    
                    weak.view.setNeedsLayout()
                    
                }
                
        }
        weak.view.layoutIfNeeded()
    }
    
    
    
    //Set cards
//    func setCards(){
//        weak var weakSelf = self
//        guard let weak = weakSelf else{return}
//
//        for view in self.stack.arrangedSubviews {
//            self.stack.removeArrangedSubview(view)
//            view.removeFromSuperview()
//        }
//
//        for  (position,card) in cards.enumerated(){
//
//            let view: PaymentRow = UIView.fromNib()
//            view.frame = CGRect(x: 0, y: 0, width: weak.view.frame.width, height: 45)
//            view.optionButton.isSelected = false
//            view.optionButton.layoutIfNeeded()
//            view.optionButton.subviews.first?.contentMode = .scaleAspectFill
//            view.optionButton.setTitle("             \(card.friendlyCard)", for: .normal)
//            view.optionButton.tag = position
//            view.optionButton.isSelected = false
//            otherButtons.append(view.optionButton)
//
//            view.optionButton.addTarget(self, action: #selector(buttonClicked(_:)), for: .touchUpInside)
//
//            weak.stack.addArrangedSubview(view.optionButton)
//            weak.view.setNeedsLayout()
//        }
//        weak.view.layoutIfNeeded()
//    }
    
    
    // MARK: - Objective C
    
}


