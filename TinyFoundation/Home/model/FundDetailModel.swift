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
    
    override init() {
        super.init()
    }
    
    convenience init(dict: Dictionary<String, Any>) {
        self.init()
        
        fundCode = dict["code"] as? String
        fundDisplayName = dict["name"] as? String
        fundType = dict["type"] as? String
    }
}
