//
//  AppDelegate.swift
//  CanLove
//
//  Created by Alex on 22/10/18.
//  Copyright © 2018 Techlatam. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import GoogleMaps
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import Stripe

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        //Enabling our own keyboard
        IQKeyboardManager.sharedManager().enable = true
        
        //Firebase delegate
        FIRApp.configure()
        
        //Delegating Stripe
        STPPaymentConfiguration.shared().publishableKey = K.stripePublishableKey
        
        //Facebook delegate
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        //Setting api key on google services for maps
        GMSServices.provideAPIKey(K.gmsServices)
        
        //--Creating instances for steps on  app
        //Singleton.shared.removeDefault(toRemove: K.defaultKeys.auth.signIn)
        let instance = Singleton.shared.checkValueSet(key: K.defaultKeys.auth.signIn)
//        if !instance.isEmpty{
//            setNewRootView(K.storyboards.menu, K.instances.mainTabBarController)
//        }
        
        
        
        return true
    }
    
    //--Setting a new rootcontroller
    func setNewRootView(_ storyboard: String, _ identifier:String){
        
        let storyboard = UIStoryboard(name: storyboard, bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: identifier )
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
    }
    
    // MARK: - Facebook/Google handler
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any]) -> Bool {
        
        let sourceApplication =  options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String
        let annotation = options[UIApplicationOpenURLOptionsKey.annotation]
        
        let facebookHandler = FBSDKApplicationDelegate.sharedInstance().application (
            app,
            open: url,
            sourceApplication: sourceApplication,
            annotation: annotation )
        
        return facebookHandler
    }

    func applicationWillResignActive(_ application: UIApplication) {}

    func applicationDidEnterBackground(_ application: UIApplication) {}

    func applicationWillEnterForeground(_ application: UIApplication) {}

    func applicationDidBecomeActive(_ application: UIApplication) {}

    func applicationWillTerminate(_ application: UIApplication) {}


}

