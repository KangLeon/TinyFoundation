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
}
