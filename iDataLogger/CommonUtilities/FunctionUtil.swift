//
//  Function.swift
//  Swift v2
//
//  Created by Swift v2 on 11/7/18.
//  Copyright © 2018 Swift v2. All rights reserved.
//

import UIKit
let KeychainItem_Service = "DataLogger"
let KeychainItem_SubscriberUUID = "subscriberID"
let KeychainItem_imeiUUID = "imei"

public class FunctionUtil: NSObject {
    
    
    public func showAlertView(withTitle title: String, andMessage message: String, fromVc vc: UIViewController) {
    
    
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    let yesButton = UIAlertAction(title: "OK", style:.default) { (UIAlertAction) in
        
    }
    
    }
    
    public func getUUIDForKey(_ keyStr: String) -> String{
        var UUID = ""
        
        do {
            UUID = try FDKeychain.item(forKey: keyStr, forService: KeychainItem_Service) as! String
            
        } catch {
            let theUUID = CFUUIDCreate(nil)
            let string = CFUUIDCreateString(nil, theUUID)
            
            UUID = (string! as String).replacingOccurrences(of: "-", with: "")
            
            FDKeychain.saveItem(UUID as NSCoding, forKey: keyStr, forService: KeychainItem_Service, error: nil)
            
        }
        return UUID
    }

}
