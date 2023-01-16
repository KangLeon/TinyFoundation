//
//  FundAllModel.swift
//  TinyFoundation
//
//  Created by 吉腾蛟 on 2021/3/5.
//

import Foundation

class FundAllModel: NSObject {
    
    var fundCode :String?
    var fundName :String?
    var fundDisplayName :String?
    var fundType :String?
    var fundFullName :String?
    
    override init() {
        super.init()
    }
    
    convenience init(array: Array<Any>) {
        self.init()
        
        fundCode = array[0] as? String
        fundName = array[1] as? String
        fundDisplayName = array[2] as? String
        fundType = array[3] as? String
        fundFullName = array[4] as? String
    }
    
    func configWithDict(dict: Dictionary<String, String>) -> FundAllModel{
        fundCode = dict["fundCode"]
        fundName = dict["fundName"]
        fundDisplayName = dict["fundDisplayName"]
        fundType = dict["fundType"]
        fundFullName = dict["fundFullName"]
        
        return self
    }
}
