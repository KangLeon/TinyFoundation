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
    @IBOutlet weak var fundTypeLabel: UILabel!
    
    @IBOutlet weak var fundNameLabel: UILabel!
    
    var detailModel: FundDetailModel?
    
    func requestGetFundDetail(fundCode: String) {
        
        NVHudManager.sharedInstance.showProgress()
        
        HN.GET(url: HOST+fund_detail,parameters: ["id": fundCode]).success { response in
            print("response -->", response)
            
            let dict = response as? Dictionary<String, Any>
            
            if dict != nil && ((dict?.keys.contains("data")) != nil){
            if let data = dict!["data"] as? Dictionary<String,Any> {
                self.detailModel = FundDetailModel(dict: data)
                }
            }
            
            self.configData()
            
            NVHudManager.sharedInstance.dismissProgress()
        }.failed { error in
            print("error -->", error.code)
            
            NVHudManager.sharedInstance.dismissProgress()
        }
    }
    
    func configData() {
        fundNameLabel.text = detailModel?.fundDisplayName
        fundTypeLabel.text = detailModel?.fundType
    }
}


extension SecondaryViewController: FundSelectionDelegate {
    func fundDidSelected(_ newFundCode: String) {
        requestGetFundDetail(fundCode: newFundCode)
    }
}
