//
//  AboutPetController.swift
//  CanLove
//
//  Created by Alex on 23/10/18.
//  Copyright © 2018 Techlatam. All rights reserved.
//

import UIKit
import Hero
import TLPhotoPicker
import DLRadioButton
import PopupDialog
import Alamofire
import Firebase

class AboutPetController: UIViewController {
    
    // MARK: - Let-Var
    
    //--Header
    open var header: HTTPHeaders{
        let token = Singleton.shared.checkValueSet(key: K.defaultKeys.auth.accessToken)
        let bearer = Core.shared.setBearerToken(token)
        return ["Authorization": bearer]
    }
    
    var selectedAssets = [TLPHAsset]()
    var selectedPrimerImage: UIImage?
    var primerImage: String?
    var selectedGender: Bool?
    var selectedBreed = Breed()
    var selectedListBreed = [ListBreed]()
    let indexPathForFirstRow = IndexPath(row: 0, section: 0)
    var avatar:String?
    var breedID:String?
    var isNewFromMypet = false
    
    
    //Model
    var newPet:NewPet?
    
        //-- From Segue --//
    var selectedImage:UIImage?
    
        //-- Self variables --//
    var lastSelectedIndexPath:IndexPath?
    
    // MARK: - Outlets
    @IBOutlet weak var dogImageView: UIImageView!
    @IBOutlet weak var canNameTextField: UITextField!{
        didSet {
            let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 2.0))
            canNameTextField.leftView = leftView
            canNameTextField.leftViewMode = .always
        }
    }
    
    @IBOutlet weak var sizeCollectionView: UICollectionView!
    @IBOutlet weak var canTypeCollectionView: UICollectionView!
    @IBOutlet weak var maleButton: DLRadioButton!
    @IBOutlet weak var selectDateDropDown: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    @IBOutlet weak var poundsTextField: UITextField!{
        didSet {
            let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 2.0))
            poundsTextField.leftView = leftView
            poundsTextField.leftViewMode = .always
        }
    }
    
    @IBOutlet weak var primerImageView: UIImageView!
    @IBOutlet weak var addPetButton: UIButton!
    
    
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setting up general actions/delegates/Core
        setUpActions()
        
        // setting up UI elements to be used through the code
        setUpUI()
        print(header)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        gettingData()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.segues.auth.aboutToMeetYourPetController {
            let detailController = segue.destination as! MeetYourPeetController
            detailController.newPet = newPet
            detailController.isNewFromMypet = isNewFromMypet
        }
    }
 
    // MARK: - SetUps / Funcs
    
    func setUpUI(){
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        
        
    }
    
    func setUpActions(){
        
        //CollectionView Delegate
        sizeCollectionView.delegate = self
        sizeCollectionView.dataSource = self
        canTypeCollectionView.delegate = self
        canTypeCollectionView.dataSource = self

        
        //Set Cell Identifier
        Core.shared.registerCellCollection(at: sizeCollectionView, named: K.cellsIdentifiers.collection.canSizeCollectionCell)
        
        Core.shared.registerCellCollection(at: canTypeCollectionView, named: K.cellsIdentifiers.collection.canTypeCollectionCell)
        
        
        //Set Can Image
        if let image = selectedImage{
            dogImageView.image = image
        }
        
        //Adding tap on our 'Dropdown'
        let gestureSelectDate = UITapGestureRecognizer(target: self, action:  #selector (checkAction(sender:)))
        selectDateDropDown.addGestureRecognizer(gestureSelectDate)
        
        
        //Set on by deafult
        maleButton.isSelected = true
        selectedGender = true
        
    }
    
    private func gettingData(){
        
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        
        DogManager().dogsBreed(header: header) {
            breed in
            guard let breed = breed else{return}
            weak.selectedBreed = breed
            
            if weak.selectedBreed.count > 0{
               
                weak.sizeCollectionView.selectItem(at: weak.indexPathForFirstRow, animated: false, scrollPosition: [])
                weak.collectionView(weak.sizeCollectionView, didSelectItemAt: weak.indexPathForFirstRow)
                weak.sizeCollectionView.reloadData()
            }
            
        }
        
    }
    
    //Setting
    func callPicker(){
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        selectedAssets.removeAll()
        
        let viewController = TLPhotosPickerViewController()
        viewController.delegate = weak
        viewController.didExceedMaximumNumberOfSelection = { [weak self] (picker) in
            self?.showExceededMaximumAlert(vc: picker)
        }
        var configure = TLPhotosPickerConfigure()
        configure.numberOfColumn = 3
        configure.maxSelectedAssets = 1
        configure.allowedVideo = false
        viewController.configure = configure
        viewController.selectedAssets = selectedAssets
        self.present(viewController, animated: true, completion: nil)
    }
    
    
    //--Select gender actions
    @IBAction func maleAction(_ sender: UIButton) {
        selectedGender = true
    }
    
    @IBAction func femaleAction(_ sender: UIButton) {
        selectedGender = false
    }
    
    @IBAction func selectPrimerImage(_ sender: UIButton) {
        callPicker()
    }
    
    @IBAction func addPetAction(_ sender: UIButton) {
        weak var weakSelf = self
        guard let weak = weakSelf else{return}

        guard let image = selectedImage else{return}
        
        firstTask(uploadImage: image) { result in
            
            if result{
                DispatchQueue.main.async {
                    Core.shared.setTitleButton(title: "Espere", at: weak.addPetButton)
                }
                
                guard let avatar = weak.avatar else {return}
                guard let name = weak.canNameTextField.text else{return}
                guard let breedID = weak.breedID else{return}
                guard let gender = weak.selectedGender else{return}
                guard let date = weak.dateLabel.text else {return}
                let dates = Singleton.shared.checkValueSet(key:K.defaultKeys.others.dateTemp)
                guard let year = Core.shared.transformStringDate(dates, fromDateFormat: K.others.dateFormat, toDateFormat: K.others.yearFormat) else{return}
                guard let weight = weak.poundsTextField.text else{return}
                guard let weightFormattedInt = Int(weight) else{return}
                guard let weightFormattedDouble = Double(exactly: weightFormattedInt) else{return}
                guard let primerImage = weak.selectedPrimerImage else{
                    let params: Parameters = ["avatar":avatar,"name":name, "breed_id":breedID, "gender":gender, "year_birthday":year, "month_birthday":"2", "weight":weightFormattedDouble]
                    weak.addPet(params: params)
                    return
                }
                    weak.secondTask(uploadImage: primerImage, completion: { result in
                        if result{
                            guard let primerImageURL = weak.primerImage else{return}
                            let params: Parameters = ["avatar":avatar,"name":name, "breed_id":breedID, "gender":gender, "year_birthday":year, "month_birthday":"2", "weight":weightFormattedDouble, "vaccine_chart": primerImageURL]
                            weak.addPet(params: params)
                        }
                    })
                }
            
            }
        
        //--Try out for new state
        //performSegue(withIdentifier: K.segues.auth.aboutToMeetYourPetController, sender: self)

    }
    
    
    @IBAction func closeModalAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    //Adding a pet
    func addPet(params:Parameters){
        
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        
        //--Registering a pet
        UserManager().registerPet(params: params, header: header) {
            result in
            
            guard let message = result?.message else{
                guard let result = result else{return}
                print(result)
                weak.newPet = result
                weak.performSegue(withIdentifier: K.segues.auth.aboutToMeetYourPetController, sender: weak)
                return
            }
            print("Error")
        }
    }
    
    //Popup with TimePicker
    func showPopup(){
        
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        
        let popup = DatePopup(nibName: K.NIB.datePopup, bundle: nil)
        DispatchQueue.main.async {
            // Create the dialog
            let popup = PopupDialog(viewController: popup, buttonAlignment: .horizontal, transitionStyle: .bounceDown, tapGestureDismissal: true)
            
            let buttonOne = CancelButton(title: "Cancelar", height: 60) {}
            
            let buttonTwo = DefaultButton(title: "Aceptar", height: 60) {
                let date = Singleton.shared.checkValueSet(key:K.defaultKeys.others.dateTemp)
                weak.dateLabel.text = date
            }
            
            popup.addButtons([buttonOne, buttonTwo])
            // Present dialog
            self.present(popup, animated: true, completion: nil)
        }
        
    }
    
    
    //Storage and change image
    func firstTask(uploadImage:UIImage,completion: @escaping (_ success: Bool) -> Void) {
        // Do something
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        
        
        var imageName: String?
        if  let firCurrentuser = FIRAuth.auth()?.currentUser, FIRAuth.auth()?.currentUser != nil{
            let userID = firCurrentuser.uid
            imageName = userID
            
        }else{
            imageName = "\(UUID().uuidString.lowercased())"
        }
        
        let storage = FIRStorage.storage().reference()
        guard let image = imageName else{return}
        let storedImage = storage.child("avatar").child(image)
        if let uploadData = UIImageJPEGRepresentation(uploadImage, 0.9)
        {
            let metaData = FIRStorageMetadata()
            metaData.contentType = "image/jpg"
            storedImage.put(uploadData, metadata: metaData, completion: { (metadata, error) in
                if error != nil{
                    print(error!)
                    weak.addPetButton.isUserInteractionEnabled = true
                    return
                }
                
                storedImage.downloadURL(completion: { (url, error) in
                    if error != nil{
                        print(error!)
                        weak.addPetButton.isUserInteractionEnabled = true
                        return
                    }else{
                        
                        guard let photo = metadata?.downloadURL()?.absoluteString else {
                            Core.shared.alert(message: "Sucedio un error con esta imagen intente de nuevo", title: "Sucedio algo:", at: self)
                            return
                        }
                        print(photo)
                        weak.avatar = photo
                        // Call completion, when finished, success or faliure
                        weak.addPetButton.isUserInteractionEnabled = false
                        completion(true)
                    }
                })
                
            })
        }
        
    }
    
    
    //Storage and change image
    func secondTask(uploadImage:UIImage,completion: @escaping (_ success: Bool) -> Void) {
        // Do something
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        
        
        var imageName: String?
        if  let firCurrentuser = FIRAuth.auth()?.currentUser, FIRAuth.auth()?.currentUser != nil{
            let userID = firCurrentuser.uid
            imageName = userID
            
        }else{
            imageName = "\(UUID().uuidString.lowercased())"
        }
        
        let storage = FIRStorage.storage().reference()
        guard let image = imageName else{return}
        let storedImage = storage.child("avatar").child(image)
        if let uploadData = UIImageJPEGRepresentation(uploadImage, 0.9)
        {
            let metaData = FIRStorageMetadata()
            metaData.contentType = "image/jpg"
            storedImage.put(uploadData, metadata: metaData, completion: { (metadata, error) in
                if error != nil{
                    print(error!)
                    weak.addPetButton.isUserInteractionEnabled = true
                    return
                }
                
                storedImage.downloadURL(completion: { (url, error) in
                    if error != nil{
                        print(error!)
                        weak.addPetButton.isUserInteractionEnabled = true
                        return
                    }else{
                        
                        guard let photo = metadata?.downloadURL()?.absoluteString else {
                            Core.shared.alert(message: "Sucedio un error con esta imagen intente de nuevo", title: "Sucedio algo:", at: self)
                            return
                        }
                        
                        weak.primerImage = photo
                        // Call completion, when finished, success or faliure
                        weak.addPetButton.isUserInteractionEnabled = false
                        completion(true)
                    }
                })
                
            })
        }
        
    }
    
    
    // MARK: - Objective C
    @objc func checkAction(sender : UITapGestureRecognizer) {
        showPopup()
    }
    
    
}
