//
//  Core.swift
//  CanLove
//
//  Created by Alex on 26/10/18.
//  Copyright © 2018 Techlatam. All rights reserved.
//


import Foundation
import UIKit
import ImageSlideshow
import HexColors
import MapKit
import SwiftMessages
import Alamofire
import Lottie
import UserNotificationsUI
import NotificationCenter
import UserNotifications
import Firebase

enum Lotties: String{
    case prueba = "prueba"
    case loading = "loading"
}
enum LottieAction{
    case play
    case stop
}


class Core {
    // MARK: - Let-Var
    static let shared = Core()
    private init() {}
    
    
    //MARK: - UI
    
    //Show Alert Message (function)
    func alert(message: String, title: String, at viewController: UIViewController){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: K.titles.textConfirmAlert, style: .cancel, handler: nil)
        alertController.addAction(okayAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    //Set a title on button
    func setTitleButton(title: String, at: UIButton){
        at.setTitle(title, for: .normal)
    }
    
    //Show share controller
    func showSharedController(at:UIViewController, text:String, image:UIImage){
        let vc = UIActivityViewController(activityItems: [text], applicationActivities: [])
        at.present(vc, animated: true, completion: nil)
    }
    
    //ImageSlider general features
    func imagesliderFeatures(slideShow:ImageSlideshow){
        slideShow.backgroundColor = .white
        slideShow.contentScaleMode = UIViewContentMode.scaleAspectFill
        slideShow.clipsToBounds = true
    }

   
    //Mapkit features
    func mapkitFeatures(mapKit:MKMapView){
        mapKit.isScrollEnabled = false
        mapKit.isUserInteractionEnabled = true
    }
    
    
    //Setting storyboards on TabPager
    func setStoryBoardName(storyboard: String, controller: String, at: UIViewController) -> UIViewController{
        return UIStoryboard(name: storyboard, bundle: nil).instantiateViewController(withIdentifier: controller)
    }
    
    
    //Making round image with Avatar
    func maskRoundedImage(image: UIImage, radius: CGFloat, selected:Bool, borderColor: UIColor) -> UIImage {
        let avatar = SwiftyAvatar(size: 20,
                                  roundess: 2,
                                  borderWidth: 2,
                                  borderColor: borderColor,
                                  background: .black)
        if selected{
            avatar.borderColor = borderColor
        }else{
            avatar.borderColor = .clear
        }
        avatar.image = image
        avatar.contentMode = .scaleAspectFill
        avatar.clipsToBounds = true
        avatar.frame.size = CGSize(width: 30, height: 30)
        let layer = avatar.layer
        
        UIGraphicsBeginImageContextWithOptions(avatar.bounds.size, false, 0.0)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let roundedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return roundedImage!
    }
    
    //Intance storyboard
    func instanceStoryboard(name:String) -> UIStoryboard {
        let storyboard = UIStoryboard(name: name, bundle: nil)
        return storyboard
    }
    
    //instantiateViewController
    func instantiateViewController(at: UIStoryboard, identifier: String) -> UIViewController {
        let instanced =  at.instantiateViewController(withIdentifier: identifier)
        return instanced
        
    }
    
    //getting some dat fro a custom URL for the most part with images
    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    
    //Showing message at bottom
    func customAlertNavbar(commerceName: String, description: String, color:UIColor, duration:SwiftMessages.Duration, layout: MessageView.Layout, at : UIView)->MessageView{
        
        //Setting view and custom config
        
        let view = MessageView.viewFromNib(layout: layout)
        var config = SwiftMessages.Config()
        
        // Theme message elements with the warning style.
        view.configureTheme(.success)
        view.button?.setTitle("Ver oferta", for: .normal)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.85)
        
        // Add a drop shadow.
        view.configureDropShadow()
        
        // Slide down from the bottom.
        config.presentationStyle = .bottom
        config.duration = duration
        
        let iconText = "😱"
        view.titleLabel?.textColor = .white
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = true
        
        view.titleLabel?.textAlignment = .center
        view.backgroundView.backgroundColor = color
        view.titleLabel?.font = UIFont.systemFont(ofSize: 15.0)
        view.bodyLabel?.font = UIFont.systemFont(ofSize: 15.0)
        view.configureContent(title: commerceName, body: description, iconText: iconText)
        view.button?.isHidden = true
        view.iconLabel?.isHidden = true
        // Show the message.
        SwiftMessages.show(config: config, view: view)
        return view
    }
    
    //Change DateFormat from datepicker
    func changeFormatDatePicker(date:Date) -> String{
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss +zzzz"
        print(inputFormatter)
        
        let showDate = inputFormatter.date(from: date.description)
        print(showDate)
        inputFormatter.dateFormat = "yyyy-MM-dd"
        let resultString = inputFormatter.string(from: showDate!)
        return resultString
    }
    
    
    //Showing message at bottom
    func customAlertNavbarProfile(commerceName: String, description: String, color:UIColor, duration:SwiftMessages.Duration, layout: MessageView.Layout, at : UIView)->MessageView{
        
        //Setting view and custom config
        
        let view = MessageView.viewFromNib(layout: layout)
        var config = SwiftMessages.Config()
        
        // Theme message elements with the warning style.
        view.configureTheme(.success)
        view.button?.setTitle("Ver oferta", for: .normal)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.85)
        
        // Add a drop shadow.
        view.configureDropShadow()
        
        // Slide down from the bottom.
        config.presentationStyle = .bottom
        config.duration = duration
        config.presentationContext = .view(at)
        
        let iconText = "😱"
        view.titleLabel?.textColor = .white
        view.backgroundColor = .clear
        view.isUserInteractionEnabled = true
        
        view.titleLabel?.textAlignment = .center
        view.backgroundView.backgroundColor = color
        view.titleLabel?.font = UIFont.systemFont(ofSize: 15.0)
        view.bodyLabel?.font = UIFont.systemFont(ofSize: 15.0)
        view.configureContent(title: commerceName, body: description, iconText: iconText)
        view.button?.isHidden = true
        view.iconLabel?.isHidden = true
        // Show the message.
        SwiftMessages.show(config: config, view: view)
        return view
    }
   
    
    
    //Create action sheet
    func createActionsheet(title: String, message: String) -> UIAlertController {
        let actionSheetController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        return actionSheetController
    }
    
    //Setting a Bearer
    func setBearerToken(_ token: String) -> String{
        let bearer = "Bearer\(" "+token)"
        return bearer
    }
    
    //Updating token
    func callOauth(){}
    
    
    
    //Setting lottie fucntions
    func playLottie(lottie: Lotties, action:LottieAction, animationView: LOTAnimationView, at: UIViewController){
        
        
        animationView.contentMode = .scaleAspectFill
        animationView.clipsToBounds = true
        at.view.addSubview(animationView)
        
        animationView.frame = at.view.frame
        animationView.center = at.view.center
        print(action)
        
        switch action {
        case .play:
            animationView.play()
            animationView.loopAnimation = true
            
        case .stop:
            
            animationView.stop()
            animationView.isHidden = true
            
        default:
            print("Error with lottie")
        }
    }
    
    //Local Notifications asking
    func askForNotifications(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) {
            (success, error) in
            
            guard success else { return }
            
            DispatchQueue.main.sync {
                print("Success")
                
            }
        }
    }
    
    //Create notification
    func buildNotification(body: String, title: String, id: String){
        let content = UNMutableNotificationContent()
        content.body =  body
        content.title = title
        
        let request = UNNotificationRequest(identifier: id, content: content, trigger: nil)
        
        UNUserNotificationCenter.current().add(request) {
            error in
            print("Error")
        }
    }
    
    //Call FIrebaseAuth
    
    func firebaseAuth(Credential credential:FIRAuthCredential) -> FIRUser?{
        
        var  userTemp:FIRUser?
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error)  in
            if let error = error{
                print(error)
            }
            userTemp = user
        })
        
        return userTemp
    }
    
    
    //Change color on imageview
    func changeImageColor(image:UIImage, color:UIColor, at: UIImageView){
        let tintImage = image.withRenderingMode(.alwaysTemplate)
        at.tintColor = color
        at.image = tintImage
    }
    
    //Return year from string date
    func returnYear(_ Date:String)->String?{
        
        let locale = Locale(identifier: "es_GT")
        let dateFormatter = DateFormatter()
        dateFormatter.locale = locale
        dateFormatter.dateFormat = "dd MMMM yyyy"
        let stringDate = dateFormatter.date(from: Date)
        dateFormatter.dateFormat = "yyyy"
        
        return stringDate?.description
    }
    
    func transformStringDate(_ dateString: String,
                             fromDateFormat: String,
                             toDateFormat: String) -> String? {
        let locale = Locale(identifier: "es_GT")
        let initalFormatter = DateFormatter()
        initalFormatter.locale = locale
        initalFormatter.dateFormat = fromDateFormat
        
        guard let initialDate = initalFormatter.date(from: dateString) else {
            print ("Error in dateString or in fromDateFormat")
            return nil
        }
        
        let resultFormatter = DateFormatter()
        resultFormatter.dateFormat = toDateFormat
        
        return resultFormatter.string(from: initialDate)
    }
    
    //Get a substring before certain character
    func stringBeforeCharacter(character:String,value: String)->String{
        var stringValue = String()
        if let range = value.range(of: character) {
            let firstPart = value[value.startIndex..<range.lowerBound]
            stringValue = firstPart.description
        }
        
        return stringValue
    }
    
    //Get a substring after certain character
    func stringAfterCharacter(character:String,value: String)->String{
        var stringValue = String()
        
        if let range = value.range(of: character) {
            let secondPart = value[range.upperBound...]
            stringValue = secondPart.description
        }
        
        return stringValue
    }
    
    
    
    
    // MARK. -XIB
    
    // Register cell at a table view
    func registerCell(at tableView: UITableView, named: String, withIdentifier: String? = nil) {
        let cellNib = UINib(nibName: named, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: withIdentifier ?? named)
    }
    
    // Register cell at a collection view
    func registerCellCollection(at collectionView: UICollectionView, named: String, withIdentifier: String? = nil) {
        let cellNib = UINib(nibName: named, bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: withIdentifier ?? named)
    }
    
}
