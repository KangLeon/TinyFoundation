//
//  Tools.swift
//  TinyFoundation
//
//  Created by Bytedance on 16/1/23.
//  Copyright © 2023 JY. All rights reserved.
//

import Foundation
import UIKit

let SCREEN_WIDTH = UIScreen.main.bounds.width
let SCREEN_HEIGHT = UIScreen.main.bounds.height

func getCurrentTimeStamp() -> String {
    let nowDate = Date.init()
    //10位数时间戳
    let interval = Int(nowDate.timeIntervalSince1970)
    //13位数时间戳 (13位数的情况比较少见)
    // let interval = CLongLong(round(nowDate.timeIntervalSince1970*1000))
    return "\(interval)"
}
