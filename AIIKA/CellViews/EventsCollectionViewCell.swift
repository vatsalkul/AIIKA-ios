//
//  EventsCollectionViewCell.swift
//  AIIKA
//
//  Created by Vatsal Kulshreshtha on 03/01/20.
//  Copyright © 2020 Vatsal Kulshreshtha. All rights reserved.
//

import UIKit

class EventsCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet var image: UIImageView!
    @IBOutlet var cntntView: UIView!
    
    @IBOutlet var opequeView: UIView!
    @IBOutlet weak var title: UILabel!
    
    var Events: Events! {
        didSet{
            self.updateUI()
        }
    }
    
    func updateUI() {
        
        if let Events = Events {
            image.image = Events.image
            title.text = Events.title
        } else
        {
            self.image.image = nil
            self.title.text = nil
        }
        
        
        cntntView.layer.shadowOffset = .zero
        
        self.cntntView.layer.shouldRasterize = true

        opequeView.layer.cornerRadius = 15.0
        image.layer.cornerRadius = 15.0
        image.layer.masksToBounds = true
        
        
    }
    
}
