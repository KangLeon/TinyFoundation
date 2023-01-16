//
//  FundAllCell.swift
//  TinyFoundation
//
//  Created by 吉腾蛟 on 2021/3/5.
//

import Foundation
import UIKit
import Defaults

class FundAllCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var type: UILabel!
    
    var dataModel :FundAllModel?
    var searchMode : Bool?
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func addFundAction(_ sender: UIButton) {
        saveDateToLocal()
    }
    
    func saveDateToLocal() {
        if let code = dataModel?.fundCode {
            Defaults[.fundCodeArray] += [code]
        }
    }
    
    func configData(model: FundAllModel!, mode: Bool) {
        searchMode = mode
        addButton.isHidden = searchMode!
        dataModel = model
        name.text = model.fundDisplayName
        number.text = model.fundCode
        type.text = model.fundType
    }
}
