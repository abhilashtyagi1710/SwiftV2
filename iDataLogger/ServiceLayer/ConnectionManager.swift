//
//  ConnectionManager.swift
//  iDataLogger
//
//  Created by Swift v2on 11/7/18.
//  Copyright © 2018 Swift v2 All rights reserved.
//

import UIKit
public enum ParsingConstant : Int
{
    case getHeartBeat
    case PostLocationRequest
}
class ConnectionManager: NSObject {
    let SERVER_ERROR = "Server not responding.\nPlease try after some time."

    public func getHeartBeatFrom(url:String,successMessage: @escaping (Any) -> Void , failureMessage : @escaping(Any) ->Void)
    {
        let imei = FunctionUtil().getUUIDForKey(KeychainItem_imeiUUID)
        let obj : HttpRequest = HttpRequest()
        obj.tag = ParsingConstant.getHeartBeat.rawValue
        obj.MethodNamee = "GET"
        obj._serviceURL = "http://demo-d1.polariswireless.com/HeartBeatAndRemoteConfig.php?HeartBeatVer=1&config_id=11&uuid=\(imei)&devicetoken="
        obj.params = [:]
        obj.doGetResponse {(success : Bool) -> Void in
            if !success
            {
                failureMessage(self.SERVER_ERROR)
            }
            else
            {
                if let remote = obj.parsedDataDict["remote"] as? [String:AnyObject]
                {
                    if let setting = remote["setting"] as? [String:AnyObject]
                    {
                        let bo = HeartBeatBO()
                        if let Auto_report_interval_in_secs = setting["Auto_report_interval_in_secs"] as? Double
                        {
                            bo.Auto_report_interval_in_secs = Auto_report_interval_in_secs
                        }
                        if let Autotest = setting["Autotest"] as? [String:AnyObject]
                        {
                         
                            if let Baro_update_rate_in_ms = Autotest["Baro_update_rate_in_ms"] as? Double
                            {
                                bo.Baro_update_rate_in_ms = Baro_update_rate_in_ms
                            }
                            if let Cellular_update_rate_in_ms = Autotest["Cellular_update_rate_in_ms"] as? Double
                            {
                                bo.Cellular_update_rate_in_ms = Cellular_update_rate_in_ms
                            }
                            if let Enable_barometer = Autotest["Enable_barometer"] as? Double
                            {
                                bo.Enable_barometer = Enable_barometer
                            }
                            if let Enable_cellular = Autotest["Enable_cellular"] as? Double
                            {
                                bo.Enable_cellular = Enable_cellular
                            }
                            if let Enable_gnss = Autotest["Enable_gnss"] as? Double
                            {
                                bo.Enable_gnss = Enable_gnss
                            }
                            if let Enable_location = Autotest["Enable_location"] as? Double
                            {
                                bo.Enable_location = Enable_location
                            }
                            if let Enable_temperature = Autotest["Enable_temperature"] as? Double
                            {
                                bo.Enable_temperature = Enable_temperature
                            }
                            if let Enable_wifi = Autotest["Enable_wifi"] as? Double
                            {
                                bo.Enable_wifi = Enable_wifi
                            }
                            if let Gnss_update_rate_in_ms = Autotest["Gnss_update_rate_in_ms"] as? Double
                            {
                                bo.Gnss_update_rate_in_ms = Gnss_update_rate_in_ms
                            }
                            if let Initial_delay = Autotest["Initial_delay"] as? Double
                            {
                                bo.Initial_delay = Initial_delay
                            }
                            if let Location_update_rate_in_ms = Autotest["Location_update_rate_in_ms"] as? Double
                            {
                                bo.Location_update_rate_in_ms = Location_update_rate_in_ms
                            }
                            if let Session_data_collection_delay_in_ms = Autotest["Session_data_collection_delay_in_ms"] as? Double
                            {
                                bo.Session_data_collection_delay_in_ms = Session_data_collection_delay_in_ms
                            }
                            if let Temperature_update_rate_in_ms = Autotest["Temperature_update_rate_in_ms"] as? Double
                            {
                                bo.Temperature_update_rate_in_ms = Temperature_update_rate_in_ms
                            }
                            if let WiFi_update_rate_in_ms = Autotest["WiFi_update_rate_in_ms"] as? Double
                            {
                                bo.WiFi_update_rate_in_ms = WiFi_update_rate_in_ms
                            }
                        }
                        if let Autotest_interval_in_secs = setting["Autotest_interval_in_secs"] as? Double
                        {
                            bo.Autotest_interval_in_secs = Autotest_interval_in_secs
                        }
                        if let Autotest_location_name = setting["Autotest_location_name"] as? String
                        {
                            bo.Autotest_location_name = Autotest_location_name
                        }
                        if let Autotest_test_count = setting["Autotest_test_count"] as? Double
                        {
                            bo.Autotest_test_count = Autotest_test_count
                        }
                        if let Barometer_update_rate_in_us = setting["Barometer_update_rate_in_us"] as? Double
                        {
                            bo.Barometer_update_rate_in_us = Barometer_update_rate_in_us
                        }
                        if let Display_server_feedback = setting["Display_server_feedback"] as? Double
                        {
                            bo.Display_server_feedback = Display_server_feedback
                        }
                        if let Enable_barometer = setting["Enable_barometer"] as? Double
                        {
                            bo.Enable_barometer = Enable_barometer
                        }
                        if let Enable_battery_monitoring = setting["Enable_battery_monitoring"] as? Double
                        {
                            bo.Enable_battery_monitoring = Enable_battery_monitoring
                        }
                        if let Enable_location_GPS = setting["Enable_location_GPS"] as? Double
                        {
                            bo.Enable_location_GPS = Enable_location_GPS
                        }
                        if let Enable_location_network = setting["Enable_location_network"] as? Double
                        {
                            bo.Enable_location_network = Enable_location_network
                        }
                        if let Enable_location_passive = setting["Enable_location_passive"] as? Double
                        {
                            bo.Enable_location_passive = Enable_location_passive
                        }
                        if let Enable_sensors = setting["Enable_sensors"] as? Double
                        {
                            bo.Enable_sensors = Enable_sensors
                        }
                        if let Enable_telephony = setting["Enable_telephony"] as? Double
                        {
                            bo.Enable_telephony = Enable_telephony
                        }
                        if let Enable_wifi = setting["Enable_wifi"] as? Double
                        {
                            bo.Enable_wifi = Enable_wifi
                        }
                        if let Heartbeat_rate_in_secs = setting["Heartbeat_rate_in_secs"] as? Double
                        {
                            bo.Heartbeat_rate_in_secs = Heartbeat_rate_in_secs
                        }
                        if let Location_GPS_update_rate_in_us = setting["Location_GPS_update_rate_in_us"] as? Double
                        {
                            bo.Location_GPS_update_rate_in_us = Location_GPS_update_rate_in_us
                        }
                        if let Location_network_update_rate_in_us = setting["Location_network_update_rate_in_us"] as? Double
                        {
                            bo.Location_network_update_rate_in_us = Location_network_update_rate_in_us
                        }
                        if let Location_passive_update_rate_in_us = setting["Location_passive_update_rate_in_us"] as? Double
                        {
                            bo.Location_passive_update_rate_in_us = Location_passive_update_rate_in_us
                        }
                        if let Phone_number = setting["Phone_number"] as? Double
                        {
                            bo.Phone_number = Phone_number
                        }
                        if let Sensors_update_rate_in_us = setting["Sensors_update_rate_in_us"] as? Double
                        {
                            bo.Sensors_update_rate_in_us = Sensors_update_rate_in_us
                        }
                        if let Server_URL = setting["Server_URL"] as? Double
                        {
                            bo.Server_URL = Server_URL
                        }
                        if let Show_gps_location = setting["Show_gps_location"] as? Double
                        {
                            bo.Show_gps_location = Show_gps_location
                        }
                        if let Show_network_location = setting["Show_network_location"] as? Double
                        {
                            bo.Show_network_location = Show_network_location
                        }
                        if let Show_passive_location = setting["Show_passive_location"] as? Double
                        {
                            bo.Show_passive_location = Show_passive_location
                        }
                        if let Telephone_update_rate_in_us = setting["Telephone_update_rate_in_us"] as? Double
                        {
                            bo.Telephone_update_rate_in_us = Telephone_update_rate_in_us
                        }
                        if let Upload_rate_in_secs = setting["Upload_rate_in_secs"] as? Double
                        {
                            bo.Upload_rate_in_secs = Upload_rate_in_secs
                        }
                        if let WiFi_update_rate_in_ms = setting["Wifi_update_rate_in_us"] as? Double
                        {
                            bo.WiFi_update_rate_in_ms = WiFi_update_rate_in_ms
                        }
                        if let battery_monitoring_update_rate_in_us = setting["battery_monitoring_update_rate_in_us"] as? Double
                        {
                            bo.battery_monitoring_update_rate_in_us = battery_monitoring_update_rate_in_us
                        }
                        successMessage(bo)

                    }
                    
                }
                else
                {
                    failureMessage(self.SERVER_ERROR)
                }
                
            }
        }
    }
    //    public func sendRequestWith(isLocReq:Bool,loc_engine:String,request_time:String,device_imsi:String,device_imei:String,location_id:String,lat:String,long:String,acc:String,alt:String,vAccuracy:String,speed:String,speedAccuracy:String,successMessage: @escaping (Any) -> Void , failureMessage : @escaping(Any) ->Void)

    func tes(isLocReq:Bool,device_imsi:String,device_imei:String,location_id:String,arrLocation:[[String:AnyObject]],successMessage: @escaping (Any) -> Void , failureMessage : @escaping(Any) ->Void)
    {
        if app_delegate.isServerReachable == true
        {
            var requestBody:Data?
//            if self.ServiceBody.count > 0
//            {
//                requestBody = self.ServiceBody.data(using: String.Encoding.utf8)
//            }
//            else
//            {
//                requestBody = self.doPrepareEnvelope().data(using: String.Encoding.utf8.rawValue)
//            }
            var strUrl = ""
            if isLocReq
            {
                strUrl = "http://demo-d1.polariswireless.com/locationRequest.php"
            }
            else
            {
                strUrl = "http://demo-d1.polariswireless.com/autoReport.php"
            }
            var webStringURL = ""
            webStringURL =    (strUrl.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)! as NSString) as String
            
            var request  = URLRequest(url: URL(string:webStringURL)!)
            
            request.httpMethod = "POST"
            request.httpBody = requestBody
            webStringURL =    webStringURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
            
            let url : URL = URL(string: webStringURL as String)!
            request.url = url
            
            print("url = ")
            print(url)
            let config = URLSessionConfiguration.ephemeral
            config.timeoutIntervalForRequest = 180.0
            config.timeoutIntervalForResource = 180.0
            let session = URLSession(configuration: config)
            let task = session.dataTask(with: request) { (data, response, err) in
                if err != nil
                {
                    failureMessage(err.debugDescription)
                }else{
                    var parsedDataDict = [String:AnyObject]()
                    let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                    print("Response : ",dataString ?? "")
                    let data = self.convertStringToDictionary(dataString! as String)
                    parsedDataDict = self.convertStringToDictionary(dataString! as String)!
                    successMessage (parsedDataDict)
                }
            }
            task.resume()
        }
        else
        {
            failureMessage("Server not reachable")
        }
        
    }
    public func sendRequestWith(isLocReq:Bool,device_imsi:String,device_imei:String,location_id:String, arrLoc:[[String:String]],arrBaro:[[String:String]],successMessage: @escaping (Any) -> Void , failureMessage : @escaping(Any) ->Void)
    {
        
        let obj : HttpRequest = HttpRequest()
        var params = [String:AnyObject]()
        var strBaro = ""
        if arrBaro.count > 0
        {
            strBaro = strBaro.appending("[")
            for baro in arrBaro
            {
                strBaro = strBaro.appending("{\"pressure\":\"" + baro["pressure"]!)
                strBaro = strBaro.appending("\",\"altitude\":\"" + baro["altitude"]!)
                strBaro = strBaro.appending("\",\"time\":\"0\"},")
            }
            strBaro.removeLast()
            strBaro.append("]")
        }
        var strLoc = ""
        
        if arrLoc.count > 0
        {
            strLoc.append("[")
            for loc in arrLoc
            {
                strLoc = strLoc.appending("{\"hAccuracy\":\"" + loc["hAccuracy"]!)
                strLoc = strLoc.appending("\",\"height\":\"" + loc["height"]!)
                strLoc = strLoc.appending("\",\"latitude\":\"" + loc["latitude"]!)
                strLoc = strLoc.appending("\",\"longitude\":\"" + loc["longitude"]!)
                strLoc = strLoc.appending("\",\"timeStamp\":\"" + loc["timeStamp"]!)
                strLoc = strLoc.appending("\",\"vAccuracy\":\"" + loc["vAccuracy"]!)
                
                strLoc = strLoc.appending("\"},")
                
            }
            strLoc.removeLast()
            strLoc.append("]")
            
        }
        
        let currentDate = Date()
        let since1970 = currentDate.timeIntervalSince1970
        let timeStamp = Int(since1970 * 1000)
        if strLoc != ""
        {
            params["location"] = "\(strLoc)" as AnyObject
        }
        if strBaro != ""
        {
            params["barometer"] = "\(strBaro)" as AnyObject
        }
        params["timeStamp"] = "\(timeStamp)" as AnyObject
        
        
        obj.tag = ParsingConstant.PostLocationRequest.rawValue
        obj.MethodNamee = "POST"
        if isLocReq
        {
            obj._serviceURL = "http://demo-d1.polariswireless.com/locationRequest.php"
        }
        else
        {
            obj._serviceURL = "http://demo-d1.polariswireless.com/autoReport.php"
        }
        
        if arrLoc.count > 0
        {
            let dict = arrLoc[arrLoc.count - 1]
            obj._serviceURL = obj._serviceURL + "?device_imei=\(device_imei)&acc=\(dict["hAccuracy"] ?? "" )request_time=0&long=\(dict["longitude"] ?? "")&location_id=\(location_id)&lat=\(dict["latitude"] ?? "")&loc_engine=HLE&alt=0&device_imsi=EC9D8F39B5484DBE96DD9C405881096E"
        }
        
        obj.params = params
        obj.doGetResponse {(success : Bool) -> Void in
            if !success
            {
                failureMessage(self.SERVER_ERROR)
            }
            else
            {
                if let response = obj.parsedDataDict["response"] as? [String:AnyObject]
                {
                    successMessage(response)
                }
                else
                {
                    failureMessage(self.SERVER_ERROR)
                }
                
            }
        }
    }

//MARK:- Utility Methods
    public func convertDictionaryToString(dict: [String:String]) -> String? {
        var strReturn = ""
        for (key,val) in dict
        {
            strReturn = strReturn.appending("\(key)=\(val)&")
        }
        strReturn = String(strReturn.dropLast())
        
        return strReturn
    }
    
    
    
    public func convertStringToDictionary(_ text: String) -> [String:AnyObject]? {
        if let data = text.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue)) {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:AnyObject]
                return json
            } catch {
                print("Something went wrong")
            }
        }
        return nil
    }
    
    public func encodeSpecialCharactersManually(_ strParam : String)-> String
    {
        
        var strParams = strParam.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlPathAllowed)
        strParams = strParams!.replacingOccurrences(of: "&", with:"%26")
        return strParams!
    }
    
    public func convertSpecialCharactersFromStringForAddress(_ strParam : String)-> String
    {
        
        var strParams = strParam.replacingOccurrences(of: "&", with:"&amp;")
        strParams = strParams.replacingOccurrences(of: ">", with: "&gt;")
        strParams = strParams.replacingOccurrences(of: "<", with: "&lt;")
        strParams = strParams.replacingOccurrences(of: "\"", with: "&quot;")
        strParams = strParams.replacingOccurrences(of: "'", with: "&apos;")
        return strParams
    }
    public func convertStringFromSpecialCharacters(strParam : String)-> String
    {
        
        var strParams = strParam.replacingOccurrences(of:"%26", with:"&")
        strParams = strParams.replacingOccurrences(of:"&amp;", with:"&")
        strParams = strParams.replacingOccurrences(of:"%3E", with: ">")
        strParams = strParams.replacingOccurrences(of:"%3C" , with: "<")
        strParams = strParams.replacingOccurrences(of:"&quot;", with: "\"")
        strParams = strParams.replacingOccurrences(of:"&apos;" , with: "'")
        
        return strParams
    }

}
