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
    var userImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.myLocationEnabled = true
        self.view = mapView
        
        self.mapView.myLocationEnabled = false
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2DMake(43.4784140, -80.5226360)
//        marker.title = "Sydney"
//        marker.snippet = "Australia"
//        marker.map = mapView
        
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        //locationManager.requestAlwaysAuthorization() //for background use
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
        
        Alamofire.request(.GET, "https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/s150/photo.jpg").response() {
            (_, _, data, _) in
            self.userImage = UIImage(data: data! )!
        }
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
        self.marker.icon = self.userImage
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error while updating location: " + error.localizedDescription)
    }
}
