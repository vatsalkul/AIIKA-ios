//
//  DataTableViewCell.swift
//  AIIKA
//
//  Created by Vatsal Kulshreshtha on 29/12/19.
//  Copyright © 2019 Vatsal Kulshreshtha. All rights reserved.
//

import UIKit

class DataTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    
    
    @IBOutlet var newsImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
