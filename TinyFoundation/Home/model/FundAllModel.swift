//
//  FundAllModel.swift
//  TinyFoundation
//
//  Created by 吉腾蛟 on 2021/3/5.
//

import Foundation

class FundAllModel: NSObject {
    
    var fundAbbreviation :String?
    var fundName :String?
    var fundNumber :String?
    var fundPinyin :String?
    var fundType :String?
    var id :String?
    
    override init() {
        super.init()
    }
    
    convenience init(dict: Dictionary<String, Any>) {
        self.init()
        
        fundAbbreviation = dict["fundAbbreviation"] as? String
        fundName = dict["fundName"] as? String
        fundNumber = dict["fundNumber"] as? String
        fundPinyin = dict["fundPinyin"] as? String
        fundType = dict["fundType"] as? String
        id = dict["id"] as? String
    }
}
