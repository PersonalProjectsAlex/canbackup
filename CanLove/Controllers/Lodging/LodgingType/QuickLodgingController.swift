//
//  QuickLodgingController.swift
//  CanLove
//
//  Created by Alex on 11/12/18.
//  Copyright © 2018 Techlatam. All rights reserved.
//

import UIKit
import Alamofire
import TagListView
import DateTimePicker
import EasyTipView


class QuickLodgingController: UIViewController, DateTimePickerDelegate {

    // MARK: - Let-Var
        //--Header
    open var header: HTTPHeaders{
        let token = Singleton.shared.checkValueSet(key: K.defaultKeys.auth.accessToken)
        let bearer = Core.shared.setBearerToken(token)
        return ["Authorization": bearer]
    }
    
    var myDogs = MyDogs()
    var selectedDog:MyDog?
    let locale =  Locale.current
    
    // MARK: - Outlets
    @IBOutlet weak var tagListView: TagListView!
    @IBOutlet weak var petsCollectionView: UICollectionView!
    
        //-Height Constraint
    @IBOutlet weak var tagListHeight: NSLayoutConstraint!
    @IBOutlet weak var tagListViewHeight: NSLayoutConstraint!
    @IBOutlet weak var hourStackHeight: NSLayoutConstraint!
    @IBOutlet weak var showHourView: UIView!
    
    
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
    
    func setUpUI(){}
    
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
            
            let picker = weak.setDateTimePicker()
            picker.show()
            
            picker.completionHandler = { date in
                
                let formatter = DateFormatter()
                formatter.locale = Locale.current
                formatter.dateFormat = "dd MMMM yyyy"
                let dateString = formatter.string(from: date)
                if let day = weak.transformStringDate(dateString, fromDateFormat:  "dd MMMM yyyy", toDateFormat: "dd") {
                   
                   weak.tagListView.addTags([day.description])
                }
                
                weak.setHeight()
            }
        }
        
        
        
    }
    
    
    func setDateTimePicker() -> DateTimePicker{
        
        let min = Date()
        let max = Date().addingTimeInterval(60 * 60 * 24 * 30)
        let picker = DateTimePicker.create(minimumDate: min, maximumDate: max)
        picker.locale = Locale(identifier: "es_GT")
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
    
    
    //Height Function
    func setHeight(){
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        DispatchQueue.main.async {
            weak.showHourView.isHidden = false
            weak.tagListHeight.constant = CGFloat(integerLiteral: 50)
            weak.tagListViewHeight.constant = CGFloat(integerLiteral: 50)
            weak.hourStackHeight.constant = CGFloat(integerLiteral: 50)
        }
        
    }
    
    // MARK: - DateTimePicker
    func dateTimePicker(_ picker: DateTimePicker, didSelectDate: Date) {
        print(didSelectDate)
        
        let formatter = DateFormatter()
        formatter.locale = locale
        formatter.dateFormat = "dd MMMM yyyy"
        let a = formatter.string(from: didSelectDate)
        print(a)
        
        formatter.dateFormat = "hh:mm aa"
        let b = formatter.string(from: didSelectDate)
        print(b)
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
    
    
    
    

}
