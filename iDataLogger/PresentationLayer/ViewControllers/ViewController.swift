//
//  ViewController.swift
//  iDataLogger
//
//  Created by Swift v2on 11/5/18.
//  Copyright © 2018 Swift v2 All rights reserved.
//

import UIKit
import CoreLocation
import CoreMotion


class ViewController: BaseViewController {

    @IBOutlet weak var secondsIntervalTxtFld: UITextField!
    @IBOutlet weak var noOfTestTxtFld: UITextField!
    @IBOutlet weak var locationNameTxtFld: UITextField!
    @IBOutlet weak var subscriberIDTxtFld: UITextField!
    @IBOutlet weak var imeiTxtFld: UITextField!
    @IBOutlet weak var responseTextView: UITextView!
    var locationTimer=Timer()
    var uuid = ""
    var subscriberID = ""
    var counter = 0
    
    var arrLoc = [[String:String]]()
    var arrBaro = [[String:String]]()

    var collectLocationTimer=Timer()
    var collectBaroTimer=Timer()

    
    @IBAction func btnStartTestClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        FDKeychain.saveItem(subscriberIDTxtFld.text! as NSCoding, forKey: KeychainItem_imeiUUID, forService: KeychainItem_Service, error: nil)
        if sender.isSelected
        {
            self.postLocationRequestToServer()
            let interval = (secondsIntervalTxtFld.text! as NSString).doubleValue
            locationTimer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true, block: { (timer) in
                self.postLocationRequestToServer()
            })

        }
        else
        {
            locationTimer.invalidate()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
        if uuid.isEmpty == true && subscriberID.isEmpty == true{
            subscriberID = FunctionUtil().getUUIDForKey(KeychainItem_imeiUUID)
             uuid = FunctionUtil().getUUIDForKey(KeychainItem_SubscriberUUID)
        }
        imeiTxtFld.text = uuid
        subscriberIDTxtFld.text = subscriberID
        LocationManager.shared.startLocationManager()
        BaroManager.shared.startBaroManager(completion: { (data) in
            DispatchQueue.main.async {
                print("Relative Altitude: \(data.relativeAltitude)")
                print("Pressure: \(data.pressure)")
                
            }
        }) { (error) in
            DispatchQueue.main.async {
                print("Error in getting Pressure: \(error)")
            }
        }
        
        self.callHeartApi()

    }
    func collectLocData()
    {
        if let loc = LocationManager.shared.location
        {
            let currentDate = Date()
            let since1970 = currentDate.timeIntervalSince1970
            let timeStamp = Int(since1970 * 1000)
            
            var dictLocTemp = [String:String]()
            dictLocTemp["hAccuracy"] = "\(loc.horizontalAccuracy)"
            dictLocTemp["height"] = "0"
            dictLocTemp["latitude"] = "\(loc.coordinate.latitude)"
            dictLocTemp["longitude"] = "\(loc.coordinate.longitude)"
            dictLocTemp["timeStamp"] = "\(timeStamp)"
            dictLocTemp["vAccuracy"] = "-1"
            arrLoc.append(dictLocTemp)
        }
    }
    func collectBaroData()
    {
        if let altdata = BaroManager.shared.altData
        {
            var dictBaroTemp = [String:String]()
            dictBaroTemp["pressure"] = "\(altdata.pressure)"
            dictBaroTemp["altitude"] = "\(altdata.relativeAltitude)"
            dictBaroTemp["time"] = "0"
            arrBaro.append(dictBaroTemp)
        }
    }

    func   postLocationRequestToServer()
    {
        if arrLoc.count <= 0
        {
            return
        }
        var dictReq = [String:AnyObject]()
        dictReq["location"] = [["hAccuracy" : "5","height" : "0","latitude" : "37.785834","longitude" : "-122.406417","timeStamp" : "1542160661.819661","vAccuracy" : "-1"],["hAccuracy" : "5","height" : "0","latitude" : "37.785834","longitude" : "-122.406417","timeStamp" : "1542160661.819661","vAccuracy" : "-1"]] as AnyObject
        let currentDate = Date()
        let since1970 = currentDate.timeIntervalSince1970
        let timeStamp = Int(since1970 * 1000)
        

        dictReq["timeStamp"] = "\(timeStamp)" as AnyObject
        counter = counter + 1
        let interval = (noOfTestTxtFld.text! as NSString).intValue
        
        if counter > interval
        {
            locationTimer.invalidate()
            return
        }
        print("Current Location : \(LocationManager.shared.location.coordinate.latitude,LocationManager.shared.location.coordinate.longitude)")
        let layer = ConnectionManager()
        layer.sendRequestWith(isLocReq: true, device_imsi: "", device_imei: uuid, location_id: locationNameTxtFld.text!, arrLoc: arrLoc,arrBaro: arrBaro, successMessage: { (response) in
            DispatchQueue.main.async {
                print("Success in Loc Service")
                self.arrBaro.removeAll()
                self.arrLoc.removeAll()
            }
        }) { (error) in
            DispatchQueue.main.async {
                print("error in Loc Service")
            }
        }
    }

    func callHeartApi()
    {
        let layer = ConnectionManager()
        layer.getHeartBeatFrom(url: "", successMessage: { (response) in
            DispatchQueue.main.async {
                print("Call Remote Config Success")
                let bo = response as! HeartBeatBO
                self.secondsIntervalTxtFld.text = "\(bo.Autotest_interval_in_secs)"
                self.noOfTestTxtFld.text = "\(bo.Autotest_test_count)"
                self.locationNameTxtFld.text = bo.Autotest_location_name
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + bo.Location_update_rate_in_ms/1000) {
                self.collectLocationTimer = Timer.scheduledTimer(withTimeInterval: bo.Location_update_rate_in_ms/1000, repeats: true, block: { (timer) in
                    self.collectLocData()
                })
                }
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + bo.Location_update_rate_in_ms/1000) {
                    
                    self.collectBaroTimer = Timer.scheduledTimer(withTimeInterval: bo.Baro_update_rate_in_ms/1000, repeats: true, block: { (timer) in
                        self.collectBaroData()
                    })
                    

                }
            }
        }) { (error) in
            DispatchQueue.main.async {
                print("Call Remote Config Error")
            }
        }
    }
}

