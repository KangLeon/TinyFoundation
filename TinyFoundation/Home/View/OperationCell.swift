//
//  OpearationCell.swift
//  TinyFoundation
//
//  Created by Bytedance on 12/1/23.
//  Copyright © 2023 JY. All rights reserved.
//

import UIKit

class OperationCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var operationNameLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configData(name: String) {
        operationNameLabel.text = name
    }
}
