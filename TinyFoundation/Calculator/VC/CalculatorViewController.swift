//
//  CalculatorViewController.swift
//  TinyFoundation
//
//  Created by Bytedance on 17/1/23.
//  Copyright © 2023 JY. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    @IBOutlet weak var buyNetValue: UITextField!
    @IBOutlet weak var buyCounts: UITextField!
    @IBOutlet weak var buyFee: UITextField!
    @IBOutlet weak var saleNetValue: UITextField!
    @IBOutlet weak var saleCounts: UITextField!
    @IBOutlet weak var saleFee: UITextField!
    
    @IBOutlet weak var earnLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension CalculatorViewController: UITextFieldDelegate {
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        calculateEarnMoney()
    }
    
    func calculateEarnMoney() {
        let buyNet = buyNetValue.text
        let buycounts = buyCounts.text
        let buyFee = buyFee.text
        let saleNet = saleNetValue.text
        let saleCount = saleCounts.text
        let saleFe = saleFee.text
        
        if buyNet?.count > 0 && buycounts?.count > 0 && 
        earnLabel.text = "1949.5"
    }
}
