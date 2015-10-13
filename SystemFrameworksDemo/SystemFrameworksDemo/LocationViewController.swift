//
//  LocationViewController.swift
//  SystemFrameworksDemo
//
//  Created by Ben Sandofsky on 10/14/14.
//  Copyright (c) 2014 CodePath. All rights reserved.
//

import UIKit
import CoreLocation
class LocationViewController: UIViewController, CLLocationManagerDelegate {

    var locationManager: CLLocationManager?
    @IBAction func didTapStart(sender: AnyObject) {
        if locationManager == nil {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
            switch CLLocationManager.authorizationStatus() {
            case .Authorized, .AuthorizedWhenInUse:
                self._startUpdating()
            case .Denied, .Restricted:
                NSLog("Provide feedback to user.")
            case .NotDetermined:
                locationManager!.requestWhenInUseAuthorization()
            }

        }
    }

    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        switch status {
        case .AuthorizedAlways, .AuthorizedWhenInUse:
            self._startUpdating()
        default:
            NSLog("Error")
        }
    }

    func _startUpdating(){
        locationManager?.startUpdatingLocation()
    }

    @IBAction func didTapStop(sender: AnyObject) {
        if locationManager != nil {
            locationManager!.stopUpdatingLocation()
            locationManager = nil
        }
    }

    @IBOutlet weak var locationLabel: UILabel!


    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation) {
        locationLabel.text = "\(newLocation.coordinate.latitude), \(newLocation.coordinate.longitude)"
    }
}
