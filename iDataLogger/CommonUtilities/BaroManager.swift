//
//  BaroManager.swift
//  iDataLogger
//
//  Created by Swift v2 on 11/11/18.
//  Copyright © 2018 Swift v2 All rights reserved.
//

import UIKit
import CoreMotion

class BaroManager: NSObject {
    static let shared = BaroManager()
    override init(){}
    let altimeter = CMAltimeter()
    var altData : CMAltitudeData!
    func startBaroManager(completion: @escaping (CMAltitudeData)->Void,failure: @escaping(Any)->Void)
    {
        // 1
        if CMAltimeter.isRelativeAltitudeAvailable() {
            // 2
            altimeter.startRelativeAltitudeUpdates(to: OperationQueue.main, withHandler: { data, error in
                // 3
                if (error == nil) {
                    self.altData = data
                    completion(data!)
                }
                else
                {
                    failure(error?.localizedDescription as Any)
                }
            })
        }
        else
        {
            failure("Altimeter Not available" as Any)
        }

    }
    func stopBaroManager()
    {
        altimeter.stopRelativeAltitudeUpdates()
    }

}
