//
//  KpTabbarController.swift
//  KPSolu
//
//  Created by Kunj on 01/12/17.
//  Copyright © 2017 Kunj. All rights reserved.
//

import UIKit

class KpTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let objSecond = self.viewControllers![1] as? SecondViewController{
            objSecond.StartLocation()
        }
        // Do any additional setup after loading the view.
    }

    
    func loadThirdData()  {
        if let objSecond = self.viewControllers![2] as? ThirdViewController{
            objSecond.GetAndReload()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
