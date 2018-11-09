//
//  ViewController.swift
//  Swift v2
//
//  Created by Swift v2 on 11/5/18.
//  Copyright © 2018 Swift v2. All rights reserved.
//

import UIKit


class ViewController: BaseViewController {

    @IBOutlet weak var secondsIntervalTxtFld: UITextField!
    @IBOutlet weak var noOfTestTxtFld: UITextField!
    @IBOutlet weak var locationNameTxtFld: UITextField!
    @IBOutlet weak var subscriberIDTxtFld: UITextField!
    @IBOutlet weak var imeiTxtFld: UITextField!
    @IBOutlet weak var responseTextView: UITextView!
    var heartBeatTimer=Timer()
    var uuid = ""
    var subscriberID = ""
    
    
    @IBAction func btnStartTestClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected
        {
            self.callHeartApi()
            heartBeatTimer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true, block: { (timer) in
                self.callHeartApi()
            })

        }
        else
        {
            heartBeatTimer.invalidate()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
        if uuid.isEmpty == true && subscriberID.isEmpty == true{
            uuid = FunctionUtil().getUUIDForKey(KeychainItem_imeiUUID)
            subscriberID = FunctionUtil().getUUIDForKey(KeychainItem_SubscriberUUID)
        }
        imeiTxtFld.text = uuid
        subscriberIDTxtFld.text = subscriberID
        
        
    }
    func callHeartApi()
    {
        let layer = ConnectionManager()
        layer.getHeartBeatFrom(url: "", successMessage: { (response) in
            DispatchQueue.main.async {
                print("Success")
                let bo = response as! HeartBeatBO
                self.noOfTestTxtFld.text = "\(bo.Autotest_test_count)"
            }
        }) { (error) in
            DispatchQueue.main.async {
                print("error")
            }
        }
    }
}

