//
//  LocationManagerCustom.swift
//  KPSolu
//
//  Created by Kunj on 01/12/17.
//  Copyright © 2017 Kunj. All rights reserved.
//

import UIKit
import CoreLocation
let APPDEL = UIApplication.shared.delegate as! AppDelegate



enum LocationErrors: Int {
    case notFetched = 0
 
}

protocol LocationUpdate {
    
    func didFoundLocation(location : CLLocation?, error: NSError?,distance : CLLocationDistance?)
    
}

class LocationManagerCustom: NSObject,CLLocationManagerDelegate {

    
    
    var delegate: LocationUpdate?
    var oldLocation: CLLocation?
    var isForDistance = false
    var distance : CLLocationDistance = 0.00

    var locationManager = CLLocationManager()

    override init() {
        super.init()
        locationManager.desiredAccuracy =  kCLLocationAccuracyBest
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
    }
    
    func stopUpdates() {
        locationManager.stopUpdatingLocation()
    }
    
    func setForSinglUpdate() {
        locationManager.requestLocation()
    }
    
    func setContiniousUpdate() {
        
        locationManager.startUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.authorizedWhenInUse {
            locationManager.requestLocation()
        }else if status == CLAuthorizationStatus.restricted || status == CLAuthorizationStatus.denied {
            self.askForEnable()
        }
        
        
    }
    
    
    func askForEnable() {
        
        let alertController = UIAlertController(title: "Location Services disabled", message: "Please enable location services.", preferredStyle: .alert)
        let oKAction = UIAlertAction(title: "Settings", style: .default,
                                     handler: { (action) in
                                        self.locationManager.delegate = self
                                        
                                        UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!, options: [:], completionHandler: { (_) in
                                            
                                        })
                                    
        })
        
        alertController.addAction(oKAction)
        
        
        OperationQueue.main.addOperation {
            APPDEL.window?.rootViewController?.present(alertController, animated: true,
                         completion:nil)
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard  let delegate = delegate else {
            return
        }
        
        if let lastLoc = locations.last {
            if isForDistance {
                if oldLocation == nil {oldLocation = lastLoc; return }

                if let distanceTmp = oldLocation?.distance(from: lastLoc) {
                    distance += distanceTmp
                    oldLocation = lastLoc
                    delegate.didFoundLocation(location: lastLoc, error: nil,distance:distance)
                }
                
            }else
            {
                delegate.didFoundLocation(location: lastLoc, error: nil,distance:nil)
            }
            return;
            
        }else {
            
            delegate.didFoundLocation(location: nil, error: NSError(domain: "", code: LocationErrors.notFetched.rawValue, userInfo: nil),distance:nil)
        }

    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        guard  let delegate = delegate else {
            return
        }
        delegate.didFoundLocation(location: nil, error: NSError(domain: "", code: LocationErrors.notFetched.rawValue, userInfo: nil), distance: nil)
    }
    
}
