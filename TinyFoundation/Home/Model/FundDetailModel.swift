//
//  FundDetailModel.swift
//  TinyFoundation
//
//  Created by JY on 12/1/23.
//  Copyright © 2023 JY. All rights reserved.
//

import Foundation

class FundDetailModel: NSObject {
    
    var fundDisplayName :String?
    var fundCode :String?
    var fundType :String?
    var expectWorth: Double?
    var expectGrowth: String?
    var lastWeekWorth: String?
    var lastMonthWorth: String?
    var lastThreeWeekWorth: String?
    var lastSixWeekWorth: String?
    var lastYearWorth: String?
    var buyFee: String?
    var buyStart: String?
    
    var netWorthData :Array<NetWorthModel>?
    
    override init() {
        super.init()
    }
    
    convenience init(dict: Dictionary<String, Any>) {
        self.init()
        
        fundCode = dict["code"] as? String
        fundDisplayName = dict["name"] as? String
        fundType = dict["type"] as? String
        expectWorth = dict["expectWorth"] as? Double
        expectGrowth = dict["expectGrowth"] as? String
        lastWeekWorth = dict["lastWeekGrowth"] as? String
        lastMonthWorth = dict["lastMonthGrowth"] as? String
        lastThreeWeekWorth = dict["lastThreeMonthsGrowth"] as? String
        lastSixWeekWorth = dict["lastSixMonthsGrowth"] as? String
        lastYearWorth = dict["lastYearGrowth"] as? String
        buyFee = dict["buyRate"] as? String
        buyStart = dict["buyMin"] as? String
        
        
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
        worthValue = Double((array[1] as? String)!)
        worthGrowth = Double((array[2] as? String)!)
        perValue = array[3] as? String
    }
}
