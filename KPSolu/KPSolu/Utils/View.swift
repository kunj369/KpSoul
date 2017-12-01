//
//  UIView+OM.swift
//  OrganiseMee
//
//  Created by Pradhyuman on 13/06/16.
//  Copyright © 2016 OrganiseMee. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

extension UIView{
    
    func dropShadow(scale: Bool = true) {
        DispatchQueue.main.async {
            
            self.layer.cornerRadius = 2.0
            let shadowSize : CGFloat = 1
            let shadowPath = UIBezierPath(rect: CGRect(x: -shadowSize / 2,
                                                       y: -shadowSize / 2,
                                                       width: self.frame.size.width + shadowSize,
                                                       height: self.frame.size.height + shadowSize))
            self.layer.masksToBounds = false
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
            self.layer.shadowOpacity = 0.15
            self.layer.shadowPath = shadowPath.cgPath
        }
        
        
        self.layoutIfNeeded()

        /*
        self.layer.masksToBounds = false
        self.layer.shadowColor = BDColor.THEME_FONT_COLOR.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: -1, height: 1)
        self.layer.shadowRadius = 5
        
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
        */
    }
    
    
    func cornerRadius(radius : CGFloat)
    {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = radius
    }
    
    func showLoader() {
        DispatchQueue.main.async {
            let progressHUD = MBProgressHUD.showAdded(to: UIApplication.shared.keyWindow!, animated: false)
            progressHUD.show(animated: true)
        }
    }
    
    func hideLoader() {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: UIApplication.shared.keyWindow!, animated: true)
        }
        
    }
    
}
