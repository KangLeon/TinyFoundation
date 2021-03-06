//
//  FundAllCell.swift
//  TinyFoundation
//
//  Created by 吉腾蛟 on 2021/3/5.
//

import Foundation
import UIKit

class FundAllCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var type: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configData(model: FundAllModel!) {
        name.text = model.fundName
        number.text = model.fundNumber
        type.text = model.fundType
    }
}
