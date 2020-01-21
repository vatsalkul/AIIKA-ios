//
//  DirectoryTableViewCell.swift
//  AIIKA
//
//  Created by Vatsal Kulshreshtha on 30/12/19.
//  Copyright © 2019 Vatsal Kulshreshtha. All rights reserved.
//

import UIKit

class DirectoryTableViewCell: UITableViewCell {

    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
