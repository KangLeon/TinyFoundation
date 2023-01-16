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
}

class PrimaryTableViewController: UITableViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    
    let cell_reuse = "fund_list_reuse_cell"
    var delegate: FundSelectionDelegate?
    var selectedIndex: Int?
    var searchMode = false
    var selectedFundArray: Array<FundAllModel>? = Array<FundAllModel>()
    var searchFundArray: Array<FundAllModel>? = Array<FundAllModel>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestGetAllFavorate()

        self.tableView.register(UINib.init(nibName: "FundAllCell", bundle: nil), forCellReuseIdentifier: cell_reuse)
        self.tableView.rowHeight = 60
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let savedCodeArray = Defaults[.fundCodeArray]
        if savedCodeArray.count > 0 {
            if selectedIndex != nil {
                delegate?.fundDidSelected(savedCodeArray[selectedIndex!])
            }else{
                delegate?.fundDidSelected(savedCodeArray[0])
            }
        }
    }
    
    func requestGetAllFavorate() {
        let savedCodeArray = Defaults[.fundCodeArray]
        
        NVHudManager.sharedInstance.showProgress()
        let keyWords = savedCodeArray.joined(separator: ",")
        
        HN.GET(url: HOST+fund_list_key,parameters: ["key_word": keyWords]).success { response in
            print("response -->", response)
            
            let dict = response as? Dictionary<String,Any>
            
            self.selectedFundArray?.removeAll()
            
            if dict != nil && ((dict?.keys.contains("data")) != nil){
                if let array = dict!["data"] as? Array<Array<Any>> {
                    for subArray in array {
                        self.selectedFundArray?.append(FundAllModel.init(array: subArray))
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
            cell.configData(model: searchFundArray?[indexPath.row])
        }else{
            cell.configData(model: selectedFundArray?[indexPath.row])
        }
        
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
