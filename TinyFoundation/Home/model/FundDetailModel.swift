//
//  FundDetailModel.swift
//  TinyFoundation
//
//  Created by Bytedance on 12/1/23.
//  Copyright © 2023 JY. All rights reserved.
//

import Foundation

class FundDetailModel: NSObject {
    
    var fundDisplayName :String?
    var fundCode :String?
    var fundType :String?
    var netWorthData :Array<NetWorthModel>?
    
    override init() {
        super.init()
    }
    
    convenience init(dict: Dictionary<String, Any>) {
        self.init()
        
        fundCode = dict["code"] as? String
        fundDisplayName = dict["name"] as? String
        fundType = dict["type"] as? String
        
        var temNetWorthDateArray :Array<NetWorthModel> = []
        if dict.keys.contains("netWorthData") {
            if let array = dict["netWorthData"] as? Array<Array<Any>> {
                for subArray in array {
                    temNetWorthDateArray.append(NetWorthModel.init(array: subArray))
                }
            }
        }
        netWorthData = temNetWorthDateArray
    }
}

class NetWorthModel: NSObject {
    
    var worthDate :String?
    var worthValue :Double?
    var worthGrowth :Double?
    var perValue: String?
    
    override init() {
        super.init()
    }
    
    convenience init(array: Array<Any>) {
        self.init()
        
        worthDate = array[0] as? String
        worthValue = array[1] as? Double
        worthGrowth = array[2] as? Double
        perValue = array[3] as? String
    }
}
