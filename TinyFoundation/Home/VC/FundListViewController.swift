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
    
    var dataArray: Array? = Array<Any>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fundList.register(UINib.init(nibName: "FundAllCell", bundle: nil), forCellReuseIdentifier: cell_reuse)
        requestGetData()
    }
    
    func requestGetData() {
        
    }
}

extension FundListViewController: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cell_reuse, for: indexPath) as! FundAllCell
        
        cell.name.text = "你好"
        
        return cell
    }
}
