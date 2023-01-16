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
    @IBOutlet weak var chartImage: UIImageView!
    @IBOutlet weak var backStackView: UIStackView!
    
    @IBOutlet weak var lastWeekNet: UILabel!
    @IBOutlet weak var lastMonthNet: UILabel!
    @IBOutlet weak var lastThreeMonthNet: UILabel!
    @IBOutlet weak var lastSixMonthNet: UILabel!
    @IBOutlet weak var lastYearNet: UILabel!
    
    
    @IBOutlet weak var buyFee: UILabel!
    @IBOutlet weak var buyStart: UILabel!
    var detailModel: FundDetailModel?
    var currneFundCode: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addUI()
    }
    
    func addUI() {
        fundChart = LineChartView()
//        view.addSubview(fundChart!)
        
//        fundChart?.snp.makeConstraints { (make) -> Void in
//            make.left.equalTo(self.view).offset(12)
//            make.right.equalTo(self.view).offset(-12)
//            make.top.equalTo(self.view).offset(64)
//            make.height.equalTo(300)
//        }
        
        for view in backStackView.subviews {
            if view.tag == 0 || view.tag == 1 || view.tag == 2 || view.tag == 3 || view.tag == 4 {
                view.layer.cornerRadius = 10
                view.layer.opacity = 0.8
            }
        }
    }
    
    func configChart() {
        let dataEntries = transformDataToEntries()
        
        let chartDataSet = LineChartDataSet(entries: dataEntries, label: "净值估算：\(detailModel?.expectWorth ?? 0) 估算涨幅：\(detailModel?.expectGrowth ?? "")")
        chartDataSet.colors = [.orange]
        chartDataSet.lineWidth = 2
        chartDataSet.circleColors = [.brown]
        chartDataSet.circleRadius = 2.1
        chartDataSet.mode = .horizontalBezier
        let chartData = LineChartData(dataSets: [chartDataSet])
        
        fundChart?.chartDescription.text = "当前净值"
        fundChart?.chartDescription.textColor = UIColor.red
        fundChart?.scaleYEnabled = false
        fundChart?.dragEnabled = true
        fundChart?.dragDecelerationEnabled = true
        fundChart?.dragDecelerationFrictionCoef = 0.9
        
        fundChart?.legend.formSize = 5
        
 
        fundChart?.data = chartData
    }
    
    func transformDataToEntries() -> Array<ChartDataEntry> {
        var dataEntries = [ChartDataEntry]()
        let arrayData = detailModel?.netWorthData
        var index = 0
        for model in arrayData! {
            let entry = ChartDataEntry.init(x: Double(index), y: Double(model.worthValue!))
            dataEntries.append(entry)
            index += 1
        }
        return dataEntries
    }
    
    
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
        lastWeekNet.text = detailModel?.lastWeekWorth
        lastMonthNet.text = detailModel?.lastMonthWorth
        lastThreeMonthNet.text = detailModel?.lastThreeWeekWorth
        lastSixMonthNet.text = detailModel?.lastSixWeekWorth
        lastYearNet.text = detailModel?.lastYearWorth
        buyFee.text = detailModel?.buyFee
        buyStart.text = detailModel?.buyStart
        
        loadFundChart()
        configChart()
    }
    
    func loadFundChart()  {
        let timeStamp = getCurrentTimeStamp()
        let path = """
http://j4.dfcfw.com/charts/pic6/\(currneFundCode ?? "").png?_=\(timeStamp)
"""
        if let url = URL(string: path) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
              guard let imageData = data else { return }

                DispatchQueue.main.async { [self] in
                  chartImage.image = UIImage.init(data: imageData)
              }
            }.resume()
          }
    }
}


extension SecondaryViewController: FundSelectionDelegate {
    func fundDidSelected(_ newFundCode: String) {
        currneFundCode = newFundCode
        requestGetFundDetail(fundCode: newFundCode)
    }
}
