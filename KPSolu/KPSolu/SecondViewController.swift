//
//  SecondViewController.swift
//  KPSolu
//
//  Created by Kunj on 01/12/17.
//  Copyright © 2017 Kunj. All rights reserved.
//

import UIKit
import CoreLocation
import MagicalRecord
import Whisper

class SecondViewController: UIViewController {

    @IBOutlet weak var lblDistance: UILabel!
    let objLocationManagerCustom = LocationManagerCustom()
    
    var isRangeComplited = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
      
        
    }
    
    func StartLocation() {
        objLocationManagerCustom.delegate = self
        objLocationManagerCustom.isForDistance = true
        objLocationManagerCustom.setContiniousUpdate()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
}

extension SecondViewController : LocationUpdate {
    
    
    func didFoundLocation(location: CLLocation?, error: NSError?,distance: CLLocationDistance?) {
        if let distance = distance {
            
             DispatchQueue.main.async {
                if self.lblDistance != nil{
                
                    self.lblDistance.text = "Total Distance : \(Double(distance).rounded(toPlaces: 2))"
            }
            
            
                if (distance >= 50 && !self.isRangeComplited) {
                self.isRangeComplited = true
               
                    
                    MagicalRecord.save({ (ObjectContext) in
                        
                        let objLocationListHistory = LocationListHistory.mr_createEntity(in: ObjectContext)
                        objLocationListHistory?.dateStart = APPDEL.startDate
                        objLocationListHistory?.dateEnd = NSDate()
                    }, completion: { (Success, error) in
                        if Success {
                            if let objTab = APPDEL.window?.rootViewController as? KpTabbarController {
                                objTab.loadThirdData()
                            }
                        }
                    })
                
                    
                    var announcement = Announcement(title: "Location", subtitle: "50 Meter complited", image: #imageLiteral(resourceName: "TabDot"))
                    announcement.duration = 2.0
                    Whisper.show(shout: announcement, to: (APPDEL.window?.rootViewController)!, completion: {
                        
                    })
                    
                    
                }
            }
            
            
            
           
        }
    }
    
}


extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
