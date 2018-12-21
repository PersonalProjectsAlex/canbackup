//
//  MenuTabBarController.swift
//  CanLove
//
//  Created by Alex on 11/11/18.
//  Copyright © 2018 Techlatam. All rights reserved.
//

import UIKit


class MenuTabBarController: UITabBarController {
    
    // MARK: - Let-Var
    var image:String?
    
    // MARK: - Outlets
    @IBOutlet weak var bottomtabBar: UITabBar!
    
    override func viewWillAppear(_ animated: Bool) {
        setUp()
        
        
    }
    
    func setUp() {
        //Setting our controllers by instances on Storyboards in order to set them
        
        let first =  Core.shared.instantiateViewController(at: Core.shared.instanceStoryboard(name: K.storyboards.walkthrough), identifier: K.instances.setNewWalkThroughController)
        
        let second =  Core.shared.instantiateViewController(at: Core.shared.instanceStoryboard(name: K.storyboards.lodging), identifier: "PruebaStackViewController")
        
        let third =  Core.shared.instantiateViewController(at: Core.shared.instanceStoryboard(name: K.storyboards.myPets), identifier: K.instances.myPetsTableController )
        
        let fourth =  Core.shared.instantiateViewController(at: Core.shared.instanceStoryboard(name: K.storyboards.profile), identifier: K.instances.profileController )
        
        //configure the view controllers here...
        viewControllers = [first, second, third, fourth]
        
        //First item
        
        tabBar.items?[0].image = #imageLiteral(resourceName: "tabbar1unselected")
        tabBar.items?[0].selectedImage = #imageLiteral(resourceName: "tabbar1selected")
        tabBar.items?[0].title =  K.titles.tabbar.item1
        
        //Second item
        tabBar.items?[1].image = #imageLiteral(resourceName: "tabbar2unselected")
        tabBar.items?[1].selectedImage = #imageLiteral(resourceName: "tabbar2selected")
        tabBar.items?[1].title = K.titles.tabbar.item2
        
        // Third item
        tabBar.items?[2].image = #imageLiteral(resourceName: "tabbar3unselected")
        tabBar.items?[2].selectedImage = #imageLiteral(resourceName: "tabbar3selected")
        tabBar.items?[2].title = K.titles.tabbar.item3
        
        let avatar = ""
        //image = avatar
        
        //let photo = !Singleton.shared.checkValueSet(key: K.defaultKeys.User.userPhoto).isEmpty ? avatar : "https://st-listas.20minutos.es/images/2011-01/269966/list_640px.jpg?1297262775"
        let photo = "https://st-listas.20minutos.es/images/2011-01/269966/list_640px.jpg?1297262775"
        guard let url = URL(string: photo) else {
            self.lastItem(at: self.tabBar, image: #imageLiteral(resourceName: "guatemala"))
            
            return
        }
        self.lastItem(at: self.tabBar, image: #imageLiteral(resourceName: "back"))
        Core.shared.getDataFromUrl(url: url) { (data, urlresponse, error) in
            if let e = error {
                print("Error downloading cat picture: \(e)")
                self.lastItem(at: self.tabBar, image: #imageLiteral(resourceName: "guatemala"))
            } else {
                // No errors found.
                // It would be weird if we didn't have a response, so check for that too.
                if let res = urlresponse as? HTTPURLResponse {
                    print("Downloaded cat picture with response code \(res.statusCode)")
                    
                    if let imageData = data {
                        // Finally convert that Data into an image and do what you wish with it.
                        
                        guard let image = UIImage(data: imageData), res.statusCode == 200 else{
                            self.lastItem(at: self.tabBar, image: #imageLiteral(resourceName: "guatemala"))
                            return
                        }
                        
                        self.lastItem(at: self.tabBar, image: image)
                        
                        // Do something with your image.
                    } else {
                        self.lastItem(at: self.tabBar, image: #imageLiteral(resourceName: "back"))
                    }
                } else {
                    self.lastItem(at: self.tabBar, image: #imageLiteral(resourceName: "back"))
                    
                }
            }
        }
        
    }
    
    
    //Getting last item on tabbar
    func lastItem(at:UITabBar, image: UIImage){
        DispatchQueue.main.async {
            at.items?[3].image = Core.shared.maskRoundedImage(image: image, radius: 50, selected: false, borderColor: .clear).withRenderingMode(.alwaysOriginal)
            at.items?[3].selectedImage = Core.shared.maskRoundedImage(image: image, radius: 50, selected: true, borderColor: .orange).withRenderingMode(.alwaysOriginal)
            at.items?[3].title = K.titles.tabbar.item4
        }
    }
    
    // MARK: - Objective C
    
}
