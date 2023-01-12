//
//  SplitViewController.swift
//  TinyFoundation
//
//  Created by JY on 12/1/23.
//  Copyright © 2023 JY. All rights reserved.
//

import Foundation
import UIKit

class SecondaryViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func requestGetFundDetail(fundCode: String) {
        
        NVHudManager.sharedInstance.showProgress()
        
        HN.GET(url: HOST+fund_detail,parameters: ["id": fundCode]).success { response in
            print("response -->", response)
            
            let dict = response as? Dictionary<String,Any>
            
            let name = ""
            
            NVHudManager.sharedInstance.dismissProgress()
        }.failed { error in
            print("error -->", error.code)
            
            NVHudManager.sharedInstance.dismissProgress()
        }
    }
}


extension SecondaryViewController: FundSelectionDelegate {
    func fundDidSelected(_ newFundCode: String) {
        requestGetFundDetail(fundCode: newFundCode)
    }
}
