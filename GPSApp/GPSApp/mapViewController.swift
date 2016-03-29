//
//  mapViewController.swift
//  GPSApp
//
//  Created by Charles Bai on 2016-01-24.
//  Copyright © 2016 Charles Bai. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation
import Alamofire

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    let mapView = GMSMapView.mapWithFrame(CGRectZero, camera: GMSCameraPosition.cameraWithLatitude(43.4784140, longitude: -80.5226360, zoom: 16))
    let marker = GMSMarker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.myLocationEnabled = true
        self.view = mapView
        
        self.mapView.myLocationEnabled = false
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //locationManager.requestAlwaysAuthorization() //for background use
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
        DownloadManager.sharedInstance.getUserImage("https://lh6.googleusercontent.com/-qIRjZyZRZ_o/AAAAAAAAAAI/AAAAAAAAL28/aLi5Ir_do60/s150/photo.jpg")
        DownloadManager.sharedInstance.getETA(["origins": "Toronto", "destinations": "Montreal"])
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate
        let parameters : [String: Double] = ["latitude": locValue.latitude, "longitude": locValue.longitude]
        DownloadManager.sharedInstance.postLocation(parameters)
        print("Broadcasting location..")
        updateMap(locValue)
    }
    
    func updateMap(position: CLLocationCoordinate2D) {
        mapView.animateToLocation(position)
        self.marker.position = position
        self.marker.map = self.mapView
        let imageView = UIImageView(image: DownloadManager.sharedInstance.userImage);
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        imageView.frame = CGRectMake(0,0, screenSize.height * 0.1, 20)
        self.marker.icon = imageView.image
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error while updating location: " + error.localizedDescription)
    }
}
