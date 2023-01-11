//
//  FundListViewController.swift
//  TinyFoundation
//
//  Created by 吉腾蛟 on 2021/3/5.
//

import Foundation
import UIKit
import Defaults

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
//        requestGetData()
    }
    
    func searchGetData() {
        NVHudManager.sharedInstance.showProgress()
        
        HN.GET(url: HOST+fund_list_key,parameters: ["key_word":searchBar?.text ?? ""]).success { response in
            print("response -->", response)
            
            let dict = response as? Dictionary<String,Any>
            
            self.searchArray?.removeAll()
            
            if dict != nil && ((dict?.keys.contains("data")) != nil){
                if let array = dict!["data"] as? Array<Array<Any>> {
                    for subArray in array {
                        self.searchArray?.append(FundAllModel.init(array: subArray))
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
    
    func saveDateToLocal(index: Int) {
        let model = searchArray?[index]
        
        if let code = model?.fundCode {
            Defaults[.fundCodeArray] += [code]
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //存储当前选中的数据到本地
        saveDateToLocal(index: indexPath.row)
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let window = delegate.keyWindows()
        let navController = window?.rootViewController as! UINavigationController
        navController.popViewController(animated: true)
    }
}

extension FundListViewController: UISearchBarDelegate{
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        isSearchActive = true
        fundList.reloadData()
        return true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if !searchText.isEmpty {
//            searchGetData()
//        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if !(searchBar.text?.isEmpty ?? false) {
            searchGetData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        cancelSearch()
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        cancelSearch()
        return true
    }
    
    func cancelSearch() {
        isSearchActive = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        fundList.reloadData()
    }
}
