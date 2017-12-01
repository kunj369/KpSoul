//
//  FirstViewController.swift
//  KPSolu
//
//  Created by Kunj on 01/12/17.
//  Copyright © 2017 Kunj. All rights reserved.
//

import UIKit
import CoreLocation

class FirstViewController: UIViewController {

    @IBOutlet weak var lblAddress: UILabel!
    var objLocationManagerCustom = LocationManagerCustom()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        objLocationManagerCustom.delegate = self
        objLocationManagerCustom.setForSinglUpdate()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension FirstViewController : LocationUpdate {
    
    
    func didFoundLocation(location: CLLocation?, error: NSError?,distance: CLLocationDistance?) {
        if let location = location {
            objLocationManagerCustom.delegate = nil
            objLocationManagerCustom.stopUpdates()
            
            self.view.showLoader()
            CLGeocoder().reverseGeocodeLocation(location, completionHandler: { (placemarkList, error) in
                self.view.hideLoader()
                if let placemarks = placemarkList {
                    if placemarks.count > 0 {
                        let placemark = placemarks[0]
                        self.lblAddress.text = "\(placemark.thoroughfare!), \(placemark.locality!), \(placemark.administrativeArea!)"
                        
                    }
                }
            })
            
        }
    }
    
}
