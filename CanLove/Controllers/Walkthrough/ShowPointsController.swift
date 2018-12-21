//
//  ShowPointsController.swift
//  CanLove
//
//  Created by Alex on 7/12/18.
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


class ShowPointsController: UIViewController,GMSMapViewDelegate {
    
    @IBOutlet weak var pruebaMapa: GMSMapView!
   
    var ref: FIRDatabaseReference!
    var lat = [Double]()
    var lon = [Double]()
    var timer = Timer()
    var isActivated = false
    var value = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        
        //Referencing to FirDatabase
        ref = FIRDatabase.database().reference()
        
            weak.getPoints()
        
        
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {}
    
    //Drawing the route
    
    private func drowRoute(lat: [Double], lon:[Double]){
        
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        
        let path = GMSMutablePath()
        for (e1, e2) in zip(lat, lon) {
          
            print("\(e1),\(e2)")
            
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
    
    
    // MARK: Firebase
    func getPoints(){
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
      
        ref.observe(.value, with: { snapshot in
            print(snapshot.childrenCount) // I got the expected number of items
            
            guard let value = snapshot.value else { return }
            do {
                
                let model = try FirebaseDecoder().decode(Points.self, from: value)
                
                for i in model{
                    let sortedArray = i.value.sorted { $0.0 < $1.key }
                   
                    for i in sortedArray{
                        
                        print("\(i.value.latitude),\(i.value.longitude)")
                        
//                        guard let firstLat = weak.lat.first, let firstLon = weak.lon.first else{return}
//                        if !weak.isActivated{
//                            let camera = GMSCameraPosition.camera(withLatitude: firstLat, longitude: firstLon, zoom: 15.0)
//                            weak.createMarker(titleMarker: "Inicio", iconMarker: #imageLiteral(resourceName: "back"), latitude: firstLat, longitude: firstLon)
//                            weak.pruebaMapa.camera = camera
//                        }
                        weak.lat.append(i.value.latitude)
                        weak.lon.append(i.value.longitude)
                        weak.pruebaMapa.delegate = self
                        weak.pruebaMapa?.isMyLocationEnabled = true
                        weak.pruebaMapa.settings.myLocationButton = true
                        weak.pruebaMapa.settings.compassButton = true
                        weak.pruebaMapa.settings.zoomGestures = true
                        weak.pruebaMapa.settings.compassButton = true
                        weak.pruebaMapa.settings.indoorPicker = true
                        
                        weak.isActivated = true
                        
                        weak.drowRoute(lat: weak.lat, lon: weak.lon)
                    }
                  
                    
                }
            } catch let error {
                print(error)
                
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



