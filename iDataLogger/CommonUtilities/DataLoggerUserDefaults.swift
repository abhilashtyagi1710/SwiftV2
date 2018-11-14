//
//  DataLoggerUserDefaults.swift
//  iDataLogger
//
//  Created by Abhilash Tyagi on 11/7/18.
//  Copyright © 2018 Polaris Wireless Inc. All rights reserved.
//

import UIKit
let RemoteTestingURL = "RemoteTestingURL"

public class DataLoggerUserDefaults: NSObject {
    
    public class func getRemoteTestingURL() -> String
    {
        let str = UserDefaults.standard.object(forKey: RemoteTestingURL) as? String ?? ""
        
        return str
    }
    
    public class func setRemoteTestingURL(object : String)
    {
        
        UserDefaults.standard.set(object, forKey:RemoteTestingURL)
        
        UserDefaults.standard.synchronize()
        
    }

}
