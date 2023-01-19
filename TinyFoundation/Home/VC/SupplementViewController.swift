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
    @IBOutlet weak var operationTableView: UITableView!
    
    var operationArray = ["净值走势","收益计算器","买卖记录","加仓","减仓","交易通知"]
    var operationIconArray = ["fund-live", "fund-calculator", "fund-operation", "fund-decrease", "fund-increase", "fund-notification"]
    
    let cell_reuse_operation = "fund_operation_cell_reuse"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        operationTableView.register(UINib.init(nibName: "OperationCell", bundle: nil), forCellReuseIdentifier: cell_reuse_operation)
        operationTableView.rowHeight = 60
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

extension SupplementViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return operationArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cell_reuse_operation, for: indexPath) as! OperationCell
        
        cell.configData(name: operationArray[indexPath.row], icon: operationIconArray[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let secondaryNav = getSecondaryNavViewController()
        secondaryNav.popViewController(animated: false)
        if indexPath.row == 0 {
        }else if indexPath.row == 1 {
            let calculatorVC = CalculatorViewController(nibName: "CalculatorViewController", bundle: nil)
            secondaryNav.pushViewController(calculatorVC, animated: false)
        }else if indexPath.row == 2 {
            let operationVC = CalculatorViewController(nibName: "OperationViewController", bundle: nil)
            secondaryNav.pushViewController(operationVC, animated: false)
        }else if indexPath.row == 3 {
            
        }else if indexPath.row == 4 {
            
        }else if indexPath.row == 5 {
            
        }
    }
}
