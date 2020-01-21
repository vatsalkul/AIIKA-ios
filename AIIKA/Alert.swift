//
//  Alert.swift
//  AIIKA
//
//  Created by Vatsal Kulshreshtha on 29/12/19.
//  Copyright © 2019 Vatsal Kulshreshtha. All rights reserved.
//

import Foundation
import UIKit

func showAlert(title: String, message: String, in vc: UIViewController){

    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
    vc.present(alert, animated: true, completion: nil)
    
}
