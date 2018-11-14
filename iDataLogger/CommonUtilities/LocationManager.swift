//
//  LocationManager.swift
//  iDataLogger
//
//  Created by Abhilash Tyagi on 10/11/18.
//  Copyright © 2018 Polaris Wireless Inc. All rights reserved.
//

import UIKit
import CoreLocation
class LocationManager: NSObject {

    var locationManager: CLLocationManager!
    var location:CLLocation!
    static let shared = LocationManager()
    override init(){}

    func startLocationManager()
    {
        locationManager = CLLocationManager()
        locationManager.requestAlwaysAuthorization()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        
    }
    

}
extension LocationManager:CLLocationManagerDelegate
{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        location = manager.location
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }

}
