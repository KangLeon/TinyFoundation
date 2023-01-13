//
//  FundChartPointModel.swift
//  TinyFoundation
//
//  Created by Bytedance on 13/1/23.
//  Copyright © 2023 JY. All rights reserved.
//

import Foundation

class FundChartPointModel: NSObject {
    
    var xValue :Double?
    var yValue :Double?
    
    override init() {
        super.init()
    }
    
    convenience init(x: Double, y: Double) {
        self.init()
        
        xValue = x
        yValue = y
    }
}
