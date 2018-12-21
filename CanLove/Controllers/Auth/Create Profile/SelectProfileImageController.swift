//
//  SelectProfileImageController.swift
//  CanLove
//
//  Created by Alex on 23/10/18.
//  Copyright © 2018 Techlatam. All rights reserved.
//

import UIKit
import TLPhotoPicker
import Hero

class SelectProfileImageController: UIViewController {

    // MARK: - Let-Var
    var selectedImage:UIImage?
    var selectedAssets = [TLPHAsset]()
    var isNewFromMypet = false
    
    // MARK: - Outlets
    
    // MARK: - LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setting up general actions/delegates/Core
        setUpActions()
        
        // setting up UI elements to be used through the code
        setUpUI()
        
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.segues.auth.selectProfileControllerToAboutPetController{
            let detailController = segue.destination as! AboutPetController
            detailController.selectedImage = selectedImage
            detailController.isNewFromMypet = isNewFromMypet
            DispatchQueue.main.async {
                detailController.hero.isEnabled = true
                detailController.hero.modalAnimationType = .zoom
            }
        }
    }
    
    // MARK: - SetUps / Funcs
    func setUpUI(){
        
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        
        DispatchQueue.main.async {
            weak.hero.isEnabled = true
            weak.hero.modalAnimationType = .zoom
        }
    }
    
    func setUpActions(){
        definesPresentationContext = true
    }
    
    private func gettingData(){}
    
    
    
    @IBAction func selectPhotoAction(_ sender: UIButton) {
        DispatchQueue.main.async {
            self.callPicker()
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
    
    
    // MARK: - Objective C
 

}
