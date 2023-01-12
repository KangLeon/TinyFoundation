//
//  SupplementViewController.swift
//  TinyFoundation
//
//  Created by JY on 12/1/23.
//  Copyright © 2023 JY. All rights reserved.
//

import Foundation
import UIKit

class SupplementViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //    func requestGetData() {
    //        NVHudManager.sharedInstance.showProgress()
    //
    //        HN.GET(url: HOST+fund_rank).success { response in
    //            print("response -->", response)
    //
    //            self.dataArray?.removeAll()
    //
    //            let dict = response as? Dictionary<String,Any>
    //
    //            if dict != nil && ((dict?.keys.contains("data")) != nil){
    //                if let array = dict!["data"] as? Array<Dictionary<String,Any>> {
    //                    for temDict in array {
    //                        self.dataArray?.append(FundAllModel.init(dict: temDict))
    //                    }
    //                }
    //            }
    //
    //            self.fundList.reloadData()
    //
    //            NVHudManager.sharedInstance.dismissProgress()
    //        }.failed { error in
    //            print("error -->", error.code)
    //
    //            NVHudManager.sharedInstance.dismissProgress()
    //        }
    //    }
}
