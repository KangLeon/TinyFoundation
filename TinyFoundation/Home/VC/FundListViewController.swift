//
//  FundListViewController.swift
//  TinyFoundation
//
//  Created by 吉腾蛟 on 2021/3/5.
//

import Foundation
import UIKit

class FundListViewController: UIViewController {
    
    @IBOutlet weak var fundList: UITableView!
    
    let cell_reuse = "fund_list_reuse_cell"
    
    var dataArray: Array<FundAllModel>? = Array<FundAllModel>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fundList.register(UINib.init(nibName: "FundAllCell", bundle: nil), forCellReuseIdentifier: cell_reuse)
        fundList.rowHeight = 60
        requestGetData()
    }
    
    func requestGetData() {
        HN.GET(url: HOST+fund_list_url).success { response in
            print("response -->", response)
            
            let dict = response as? Dictionary<String,Any>
            
            if dict != nil && ((dict?.keys.contains("data")) != nil){
                
                if let array = dict!["data"] as? Array<Dictionary<String,Any>> {
                    for temDict in array {
                        self.dataArray?.append(FundAllModel.init(dict: temDict))
                    }
                }
            }
            
            print(self.dataArray)
            
        }.failed { error in
            print("error -->", error)
        }
    }
}

extension FundListViewController: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cell_reuse, for: indexPath) as! FundAllCell
        
        cell.configData(model: dataArray?[indexPath.row])
        
        return cell
    }
}
