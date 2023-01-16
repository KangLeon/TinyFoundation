//
//  OpearationCell.swift
//  TinyFoundation
//
//  Created by JY on 12/1/23.
//  Copyright © 2023 JY. All rights reserved.
//

import UIKit

class OperationCell: UITableViewCell {

    @IBOutlet weak var operationIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var operationNameLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configData(name: String, icon: String) {
        operationNameLabel.text = name
        operationIcon.image = UIImage(named: icon)
    }
}
