//
//  ViewController.swift
//  TinyFoundation
//
//  Created by 吉腾蛟 on 2021/3/2.
//

import UIKit
import Defaults

class ViewController: UIViewController {
    @IBOutlet weak var addNewFundButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    
    var dataArray: Array<FundAllModel>? = Array<FundAllModel>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let fundCodeArray = Defaults[.fundCodeArray]
        if fundCodeArray.count > 0 {
            
        }
    }
    
    func requestGetData() {
        NVHudManager.sharedInstance.showProgress()

        HN.GET(url: HOST+fund_rank).success { response in
            print("response -->", response)

            self.dataArray?.removeAll()

            let dict = response as? Dictionary<String,Any>

//            if dict != nil && ((dict?.keys.contains("data")) != nil){
//                if let array = dict!["data"] as? Array<Dictionary<String,Any>> {
//                    for temDict in array {
//                        self.dataArray?.append(FundAllModel.init(dict: temDict))
//                    }
//                }
//            }

            self.fundList.reloadData()

            NVHudManager.sharedInstance.dismissProgress()
        }.failed { error in
            print("error -->", error.code)

            NVHudManager.sharedInstance.dismissProgress()
        }
    }
}

extension Defaults.Keys {
    static let fundCodeArray = Key<Array<String>>("fund_code_array", default: [])
}
