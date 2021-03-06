//
//  FundListViewController.swift
//  TinyFoundation
//
//  Created by 吉腾蛟 on 2021/3/5.
//

import Foundation
import UIKit
import NVActivityIndicatorView

class FundListViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var fundList: UITableView!
    
    let cell_reuse = "fund_list_reuse_cell"
    
    var isSearchActive :Bool = false
    
    var dataArray: Array<FundAllModel>? = Array<FundAllModel>()
    var searchArray: Array<FundAllModel>? = Array<FundAllModel>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fundList.register(UINib.init(nibName: "FundAllCell", bundle: nil), forCellReuseIdentifier: cell_reuse)
        fundList.rowHeight = 60
        requestGetData()
    }
    
    func requestGetData() {
        NVHudManager.sharedInstance.showProgress()
        
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
            
            self.fundList.reloadData()
            
            NVHudManager.sharedInstance.dismissProgress()
        }.failed { error in
            print("error -->", error.code)
            
            NVHudManager.sharedInstance.dismissProgress()
        }
    }
}

extension FundListViewController: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearchActive {
            return searchArray?.count ?? 0
        }else{
            return dataArray?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cell_reuse, for: indexPath) as! FundAllCell
        
        if isSearchActive {
            cell.configData(model: searchArray?[indexPath.row])
        }else{
            cell.configData(model: dataArray?[indexPath.row])
        }
        
        return cell
    }
}

extension FundListViewController: UISearchBarDelegate{
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        isSearchActive = true
        fundList.reloadData()
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            searchArray = fundList.
        }
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        isSearchActive = false
        fundList.reloadData()
        return true
    }
}
