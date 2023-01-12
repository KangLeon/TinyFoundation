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
}

extension Defaults.Keys {
    static let fundCodeArray = Key<Array<String>>("fund_code_array", default: [])
}
