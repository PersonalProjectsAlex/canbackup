//
//  AddCardController.swift
//  CanLove
//
//  Created by Alex on 14/12/18.
//  Copyright © 2018 Techlatam. All rights reserved.
//

import UIKit
import Stripe
import Alamofire
import InputMask
import SwiftLuhn

class AddCardController: UIViewController, MaskedTextFieldDelegateListener {
    
    // MARK: - Let-Var
        //--Header
    open var header: HTTPHeaders{
        let token = Singleton.shared.checkValueSet(key: K.defaultKeys.auth.accessToken)
        let bearer = Core.shared.setBearerToken(token)
        return ["Authorization": bearer]
    }
    @IBOutlet weak var dateListener: MaskedTextFieldDelegate!
    @IBOutlet weak var cvvListener: MaskedTextFieldDelegate!
    @IBOutlet weak var cardNumberTextfield: UITextField!
    @IBOutlet weak var dateTextfield: UITextField!
    @IBOutlet weak var cvcTextfield: UITextField!
    @IBOutlet weak var addCardButton: UIButton!
    @IBOutlet weak var scrollview: UIScrollView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {}
    
    // MARK: - SetUps / Funcs
    
    func setUpUI(){}
    
    func setUpActions(){
        
        //Inidicator
        indicator.isHidden = true
        
    }
    
    private func gettingData(){}

    @IBAction func addCardAction(_ sender: UIButton) {
        indicator.isHidden = false
        indicator.startAnimating()
        guard let cardNumber = cardNumberTextfield.text else{return}
        guard let cvc = cvcTextfield.text else{return}
        guard let date = dateTextfield.text else{return}
        
        guard let month = Int(Core.shared.stringBeforeCharacter(character: "/", value: date)) else{return}
        guard let year = Int(Core.shared.stringAfterCharacter(character: "/", value: date)) else{return}
        
        if cardNumber.isValidCardNumber(){
            addCard(cardNumber: cardNumber, month: month , year: year, cvc: cvc)
        }
    }
    
    
    @IBAction func backAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func addCard(
        cardNumber:String,
        month:Int,
        year: Int,
        cvc: String
        ){
        
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        
        let cardParams = STPCardParams()
    
        
        cardParams.number = cardNumber
        cardParams.expMonth = UInt(month)
        cardParams.expYear = UInt(year)
        cardParams.cvc = cvc
        
        
            STPAPIClient.shared().createToken(withCard: cardParams) { (token: STPToken?, error: Error?) in
                guard let token = token, error == nil else {
                    Core.shared.alert(message: K.titles.cardIssueStripe, title: K.titles.alertWrongTitle, at: weak)
                    weak.indicator.isHidden = true
                    weak.indicator.stopAnimating()
                    return
                }
                
                let parameters:Parameters = ["stripe_source": token.stripeID]
                UserManager().registerNewCard(header: weak.header, params: parameters, completionHandler: {
                    cards in
                    guard let cards  = cards else{
                        
                        weak.indicator.isHidden = true
                        weak.indicator.stopAnimating()
                        return
                    }
                    weak.dismiss(animated: true, completion: nil) 
                    
                })
                
                
            }
        }
    
    // MARK: - Objective C

    
    // MARK: - Textfield
    
}
