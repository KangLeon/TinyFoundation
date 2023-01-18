//
//  PrimaryTableViewController.swift
//  TinyFoundation
//
//  Created by JY on 12/1/23.
//  Copyright © 2023 JY. All rights reserved.
//

import UIKit
import Defaults

protocol FundSelectionDelegate: UIViewController {
  func fundDidSelected(_ newFundCode: String)
}

extension Defaults.Keys {
    static let fundCodeArray = Key<Array<String>>("fund_code_array", default: [])
    static let fundModelArray = Key<Array<Dictionary<String, String>>>("fund_Model_array", default: [])
}

class PrimaryTableViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    
    @IBOutlet weak var addButton: UIBarButtonItem!
    let cell_reuse = "fund_list_reuse_cell"
    var delegate: FundSelectionDelegate?
    var selectedCode: String?
    var selectedIndex: Int?
    var searchMode: Bool = false {
            willSet(newValue) {
                print("searchMode will change to \(newValue)")
            }
            didSet(newValue) {
                if #available(macCatalyst 16.0, *) {
                    deleteButton.isHidden = !newValue
                } else {
                    // Fallback on earlier versions
                    deleteButton.isEnabled = !newValue
                }
            }
        }
    var selectedFundArray: Array<FundAllModel>? = Array<FundAllModel>()
    var searchFundArray: Array<FundAllModel>? = Array<FundAllModel>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestGetAllFavorate()

        self.tableView.register(UINib.init(nibName: "FundAllCell", bundle: nil), forCellReuseIdentifier: cell_reuse)
        self.tableView.rowHeight = 80
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        var savedCodeArray = Defaults[.fundCodeArray]
//        savedCodeArray.remove(at: 0)
//        var savedModelArray = Defaults[.fundModelArray]
//        savedModelArray.remove(at: 0)
//        Defaults[.fundModelArray] = savedModelArray
//        Defaults[.fundCodeArray] = savedCodeArray
        delegateNeedChange()
    }
    
    func delegateNeedChange() {
        let savedCodeArray = Defaults[.fundCodeArray]
        let _ = Defaults[.fundModelArray]
        if savedCodeArray.count > 0 {
            if selectedCode != nil {
                delegate?.fundDidSelected(selectedCode ?? "")
            }else{
                delegate?.fundDidSelected(savedCodeArray[0])
            }
        }
    }
    
    func requestGetAllFavorate() {
        let savedModelArray = Defaults[.fundModelArray]
        self.selectedFundArray?.removeAll()
        for dict in savedModelArray {
            let model = FundAllModel.init().configWithDict(dict: dict)
            self.selectedFundArray?.append(model.configWithDict(dict: dict))
        }
        self.tableView.reloadData()
        
        requestCurrentNetValue()
    }
    
    func searchGetData() {
        NVHudManager.sharedInstance.showProgress()
        
        HN.GET(url: HOST+fund_list_key,parameters: ["key_word":searchBar?.text ?? ""]).success { response in
            print("response -->", response)
            
            let dict = response as? Dictionary<String,Any>
            
            self.searchFundArray?.removeAll()
            
            if dict != nil && ((dict?.keys.contains("data")) != nil){
                if let array = dict!["data"] as? Array<Array<Any>> {
                    for subArray in array {
                        self.searchFundArray?.append(FundAllModel.init(array: subArray))
                    }
                }
            }
            
            self.tableView.reloadData()
            
            NVHudManager.sharedInstance.dismissProgress()
        }.failed { error in
            print("error -->", error.code)
            
            NVHudManager.sharedInstance.dismissProgress()
        }
    }
    
    func requestCurrentNetValue() {
        let savedModelArray = Defaults[.fundCodeArray]
        
        let keywords = savedModelArray.joined(separator: ",")
        
        HN.GET(url: HOST+fund_summary,parameters: ["id": keywords]).success { response in
            print("response -->", response)
            
            let dict = response as? Dictionary<String,Any>
            
            if dict != nil && ((dict?.keys.contains("data")) != nil){
                if let array = dict!["data"] as? Array<Dictionary<String, Any>> {
                    for dict in array {
                        let fundCode = dict["code"] as? String
                        if let index = self.selectedFundArray?.firstIndex(where: { model in
                            model.fundCode == fundCode
                        }) {
                            self.selectedFundArray![index].fundNet = (dict["expectGrowth"] as? String)!
                        }
                    }
                }
            }
            
            self.tableView.reloadData()
            self.tableView.selectRow(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .top)
        }.failed { error in
            print("error -->", error.code)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchMode {
            return searchFundArray?.count ?? 0
        }else{
            return selectedFundArray?.count ?? 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cell_reuse, for: indexPath) as! FundAllCell
        
        if searchMode {
            cell.configData(model: searchFundArray?[indexPath.row], mode: searchMode)
        }else{
            cell.configData(model: selectedFundArray?[indexPath.row], mode: searchMode)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! FundAllCell
        selectedIndex = indexPath.row
        if selectedCode != cell.dataModel?.fundCode {
            selectedCode = cell.dataModel?.fundCode
            delegateNeedChange()
        } else {
            return
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            deleteRowAtIndexPath(indexPath: indexPath)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        
    }

    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func deleteRowAtIndexPath(indexPath: IndexPath) {
        var savedCodeArray = Defaults[.fundCodeArray]
        tableView.beginUpdates()
        if savedCodeArray.count > 0 {
            let cell = tableView.cellForRow(at: indexPath) as! FundAllCell
            let index = savedCodeArray.firstIndex(where: { code in
                code == cell.dataModel?.fundCode
            })
            if let indeX = index {
                savedCodeArray.remove(at: indeX)
                var savedModelArray = Defaults[.fundModelArray]
                savedModelArray.remove(at: indeX)
                Defaults[.fundModelArray] = savedModelArray
                Defaults[.fundCodeArray] = savedCodeArray
                selectedFundArray?.remove(at: indeX)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
        tableView.endUpdates()
        if savedCodeArray.count == 0 {
            tableView.isEditing = false
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "取消跟踪"
    }

    @IBAction func addFundAction(_ sender: Any) {
        if !searchMode {
            searchBar.becomeFirstResponder()
        }else{
            cancelSearch()
        }
    }
    @IBAction func deleteFundAction(_ sender: UIBarButtonItem) {
        tableView.isEditing = !tableView.isEditing
    }
}


extension PrimaryTableViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchMode = true
        tableView.reloadData()
        return true
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
        searchMode = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        searchFundArray?.removeAll()
        requestGetAllFavorate()
    }
}
