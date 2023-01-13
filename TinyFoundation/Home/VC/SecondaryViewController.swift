//
//  SplitViewController.swift
//  TinyFoundation
//
//  Created by JY on 12/1/23.
//  Copyright © 2023 JY. All rights reserved.
//

import Foundation
import UIKit
import Charts
import SnapKit

class SecondaryViewController: UIViewController {
    var fundChart: LineChartView?
    @IBOutlet weak var fundTypeLabel: UILabel!
    @IBOutlet weak var fundNameLabel: UILabel!
    @IBOutlet weak var settingsButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fundChart = LineChartView()
        view.addSubview(fundChart!)
        
        fundChart?.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(self.view).offset(12)
            make.right.equalTo(self.view).offset(-12)
            make.top.equalTo(self.settingsButton.snp_bottomMargin).offset(12)
            make.height.equalTo(300)
        }
        
        configChart()
    }
    
    func configChart() {
        var dataEntries = [ChartDataEntry]()
        for i in 0..<20 {
            let y = arc4random()%100
            let entry = ChartDataEntry.init(x: Double(i), y: Double(y))
            dataEntries.append(entry)
        }
        
        let chartDataSet = LineChartDataSet(entries: dataEntries, label: "净值估算：估算涨幅")
        let chartData = LineChartData(dataSets: [chartDataSet])
        
        fundChart?.chartDescription.text = "当前净值"
        fundChart?.chartDescription.textColor = UIColor.red
        fundChart?.scaleYEnabled = false
        fundChart?.dragEnabled = true
        fundChart?.dragDecelerationEnabled = true
        fundChart?.dragDecelerationFrictionCoef = 0.9
 
        fundChart?.data = chartData
    }
    
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
