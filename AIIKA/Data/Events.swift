//
//  Events.swift
//  AIIKA
//
//  Created by Vatsal Kulshreshtha on 03/01/20.
//  Copyright © 2020 Vatsal Kulshreshtha. All rights reserved.
//

import UIKit

class Events {
     
    var title: String = ""
    var color: UIColor
    var image: UIImage
    
    init(title: String, color: UIColor, image: UIImage){
        
        self.title = title
        self.color = color
        self.image = image
    }
    
    static func fetchEvents() -> [Events] {
        
        return [
            Events(title: "AIIKA Foundation Day", color: UIColor(red: 63/255, green: 71/255, blue: 80/255, alpha: 0.8), image: UIImage(named: "f1")!),
            Events(title: "AIIKA MAA Tujhe Salam", color: UIColor(red: 240/255, green: 133/255, blue: 91/255, alpha: 0.8), image: UIImage(named: "f2")!),
            Events(title: "AIIKA CELEBS", color: UIColor(red: 105/255, green: 80/255, blue: 227/255, alpha: 0.8), image: UIImage(named: "f3")!)
        ]
        
        
        
    }
    
}
