//
//  PruebaController.swift
//  CanLove
//
//  Created by Alex on 4/12/18.
//  Copyright © 2018 Techlatam. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire
import SwiftyJSON
import Firebase
import FirebaseDatabase
import SwiftLocation
import CodableFirebase


class PruebaController: UIViewController,GMSMapViewDelegate {

    @IBOutlet weak var pruebaMapa: GMSMapView!
    var ref: FIRDatabaseReference!
    var lat = [Double]()
    var lon = [Double]()
    var timer = Timer()
    var isActivated = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Referencing to FirDatabase
        ref = FIRDatabase.database().reference()
        
        
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        Location.getLocation(accuracy: .city, frequency: .oneShot, success: { (request, location) -> (Void) in
            //print("Prueba:\(location.coordinate)")
            
            weak.lat.append(location.coordinate.latitude)
            weak.lon.append(location.coordinate.longitude)
            
            //Map initiation code
            let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 15.0)
            DispatchQueue.main.async {
                weak.pruebaMapa.camera = camera
                weak.pruebaMapa.delegate = self
                weak.pruebaMapa?.isMyLocationEnabled = true
                weak.pruebaMapa.settings.myLocationButton = true
                weak.pruebaMapa.settings.compassButton = true
                weak.pruebaMapa.settings.zoomGestures = true
                weak.pruebaMapa.settings.compassButton = true
                weak.pruebaMapa.settings.indoorPicker = true
            }
            
            
            weak.createMarker(titleMarker: "Inicio", iconMarker: #imageLiteral(resourceName: "back") , latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            weak.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(weak.fireTimer), userInfo: nil, repeats: true)
            
        }) { (reques, location, error) -> (Void) in
            print(error)
            
        }
        
        
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { (timer) in
            if weak.isActivated{
                weak.timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(weak.fireTimer), userInfo: nil, repeats: true)
            }
        }
        
       
//        Location.onReceiveNewLocation = { location in
//            print(location)
//
//        }
//
        
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {}
    
    //Adding a location to firebase
    func addToFirebase(currentTime: String){
        
        
        ref.observeSingleEvent(of: .value, with: { snapshot in
            weak var weakSelf = self
            guard let weak = weakSelf else{return}
            
            if !snapshot.exists() { return }
            
            
            if weak.lat.count > 0 && weak.lon.count > 0{
                
                Location.getLocation(accuracy: .city, frequency: .oneShot, success: { (request, location) -> (Void) in
                    print("Prueba:\(location.coordinate)")
                    
                    weak.lat.append(location.coordinate.latitude)
                    weak.lon.append(location.coordinate.longitude)
                    weak.drowRoute(lat: weak.lat, lon: weak.lon)
                    weak.ref.child("1dadd61b-fac0-46e1-b0bb-3dba3949e41e").child(currentTime).setValue(["latitude": location.coordinate.latitude, "longitude": location.coordinate.longitude])
                    //weak.getPoints()
                }) { (reques, location, error) -> (Void) in
                    print(error)
                    
                }
            
            }else{
                
                weak.drowRoute(lat: weak.lat, lon: weak.lon)
                weak.isActivated = true
            }
            
        })
        
    }
    
    @IBAction func stopAction(_ sender: UIButton) {
        if let lat = lat.last, let lon = lon.last{
            
            self.createMarker(titleMarker: "Fin", iconMarker: #imageLiteral(resourceName: "back") , latitude: lat ,longitude: lon)
            self.timer.invalidate()
        }
    }
    
    
    
    //Drawing the route
    
    private func drowRoute(lat: [Double], lon:[Double]){
        
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        let path = GMSMutablePath()
        for (e1, e2) in zip(lat, lon) {
            path.addLatitude(e1, longitude: e2)
        }
        DispatchQueue.main.async {
            let polyline = GMSPolyline(path: path)
            polyline.strokeWidth = 2.5
            polyline.strokeColor = #colorLiteral(red: 0.1373712122, green: 0.345433712, blue: 0.4244714379, alpha: 1)
            polyline.geodesic = true
            polyline.map = weak.pruebaMapa
        }
        
    }
    
    //Action to repeat
    @objc func fireTimer() {
        guard let currentTime = Date().toMillis()?.description else{return}
        addToFirebase(currentTime: currentTime)
    }
    
    
    
    // MARK: Firebase
    func getPoints(){
        
        ref.observeSingleEvent(of: .value, with: { snapshot in
            print(snapshot.childrenCount) // I got the expected number of items
            
            guard let value = snapshot.value else { return }
            do {
                let model = try FirebaseDecoder().decode(Points.self, from: value)
                print(model)
//                for i in model.user1{
//                   print("\( i.value.lat),\( i.value.long)")
//                    
//                }
            } catch let error {
                print(error)
            }
            
            let enumerator = snapshot.children
            while let rest = enumerator.nextObject() as? FIRDataSnapshot {
                print(rest.value)
                let name = (rest.value as? [String : AnyObject])?["lat"]
                print(name)
                
            }
        })
    }
    
    // MARK: Extras
    
    func createMarker(titleMarker: String, iconMarker: UIImage, latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2DMake(latitude, longitude)
        marker.title = titleMarker
        marker.icon = iconMarker
        marker.map = pruebaMapa
    }
   
    
}

