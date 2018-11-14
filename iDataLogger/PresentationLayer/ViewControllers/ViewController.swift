//
//  ViewController.swift
//  iDataLogger
//
//  Created by Abhilash Tyagion 11/5/18.
//  Copyright © 2018 Polaris Wireless Inc. All rights reserved.
//

import UIKit


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
       // noOfTestTxtFld.text = "300"
       // secondsIntervalTxtFld.text = "5"
       // locationNameTxtFld.text = "TP"
        self.callHeartApi()

    }
    func   postLocationRequestToServer()
    {
        
        counter = counter + 1
        let interval = (noOfTestTxtFld.text! as NSString).intValue

        if counter > interval
        {
            counter = 0
            locationTimer.invalidate()
            return
        }
        print("Current Location : \(LocationManager.shared.location.coordinate.latitude,LocationManager.shared.location.coordinate.longitude)")
        let layer = ConnectionManager()
//        layer.sendRequestWith(isLocReq:true,loc_engine: "HLE", request_time: "0", device_imsi: "405861004463230", device_imei: "865124034527731", location_id: "TP", lat: "12.88943307", long: "77.55161143", acc: "166.16", alt: "826.783203125", vAccuracy: "64.0", speed: "0.0", speedAccuracy: "2.0671237", successMessage:
//            { (response) in
//                DispatchQueue.main.async {
//                    print("Success")
//                }
//
//        }) { (error) in
//            DispatchQueue.main.async {
//                print("error")
//            }
//
//        }
        
                layer.sendRequestWith(isLocReq:false,loc_engine: "HLE", request_time: "0", device_imsi: subscriberID, device_imei: uuid, location_id: locationNameTxtFld.text!, lat: "\(LocationManager.shared.location.coordinate.latitude)", long: "\(LocationManager.shared.location.coordinate.longitude)", acc: "\(LocationManager.shared.location.horizontalAccuracy)", alt: "\(LocationManager.shared.location.altitude)", vAccuracy: "\(LocationManager.shared.location.verticalAccuracy)", speed: "\(LocationManager.shared.location.speed)", speedAccuracy: "2.0671237", successMessage: { (response) in
                    DispatchQueue.main.async {
                        print("Post LocationRequest Success")
                    }
        
                }) { (error) in
                    DispatchQueue.main.async {
                        print("Post LocationRequest error")
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
            }
        }) { (error) in
            DispatchQueue.main.async {
                print("Call Remote Config Error")
            }
        }
    }
}

