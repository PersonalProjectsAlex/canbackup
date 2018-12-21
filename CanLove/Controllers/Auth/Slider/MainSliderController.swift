//
//  MainSliderController.swift
//  Tugo
//
//  Created by Alex on 17/8/18.
//  Copyright © 2018 Tugo. All rights reserved.
//

import Foundation
import UIKit
import RevealingSplashView

class MainSliderController: UIViewController, OnboardingViewControllerDelegate {
    
    // MARK: - Let-Var
    
    // MARK: - Outlets
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var jumButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let onboardingViewController = segue.destination as? OnboardingViewController {
            onboardingViewController.onboardingDelegate = self
        }
    }
    
    func onboardingPageViewController(onboardingPageViewController: OnboardingViewController, didUpdatePageCount count: Int) {
        pageControl.numberOfPages = count
    }
    
    func onboardingPageViewController(onboardingPageViewController: OnboardingViewController, didUpdatePageIndex index: Int) {
        pageControl.currentPage = index
        switch pageControl.currentPage {
        case 0:
            stateButton(nexButtonState: false, jumButtonState: true)
        case 1:
            
            stateButton(nexButtonState: false, jumButtonState: true)
        case 2:
            stateButton(nexButtonState: true, jumButtonState: false)
            
        default:
            return
        }
    }
    
    func stateButton(nexButtonState: Bool, jumButtonState: Bool){
        let nextTitle = !nexButtonState ?  "    " : "Comenzar"
        nextButton.setTitle(nextTitle, for: .normal)
        nextButton.isEnabled = nexButtonState
        
        let jumpTitle = !jumButtonState ?  "    " : "Saltar"
        jumButton.isEnabled = jumButtonState
        jumButton.setTitle(jumpTitle, for: .normal)
    }
    
    @IBAction func saveSkipAction(_ sender: UIButton) {
        
    }
    
 
}

