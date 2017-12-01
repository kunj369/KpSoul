//
//  ThirdViewController.swift
//  KPSolu
//
//  Created by Kunj on 01/12/17.
//  Copyright © 2017 Kunj. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

    @IBOutlet weak var tblMain: UITableView!
    
    var arrLocationList : [LocationListHistory] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
        GetAndReload()
    }
    
    
    func GetAndReload() {
        
        arrLocationList.removeAll()
        arrLocationList =  LocationListHistory.mr_findAll() as! [LocationListHistory]
        if tblMain != nil {
            tblMain.reloadData()
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
    
    
    func dateToString(date : NSDate,formate : String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = formate
        return formatter.string(from: date as Date)
    }
    
}



extension ThirdViewController:UITableViewDataSource,UITableViewDelegate{
    
  
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrLocationList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let lblDate = cell.viewWithTag(1) as! UILabel
        let lblDateTime = cell.viewWithTag(2) as! UILabel
        
        let objLoc = arrLocationList[indexPath.row]
        lblDate.text = self.dateToString(date: objLoc.dateStart!, formate: "MM-dd-yyyy")
        lblDateTime.text = self.dateToString(date: objLoc.dateEnd!, formate: "MM-dd-yyyy HH:mm:ss")
        
        
        cell.layoutIfNeeded()
        return cell
        
    }
   
    
}

