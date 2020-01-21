//
//  ContactDetailViewController.swift
//  AIIKA
//
//  Created by Vatsal Kulshreshtha on 08/01/20.
//  Copyright © 2020 Vatsal Kulshreshtha. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController {
    
    
    @IBOutlet var nameLabel: UILabel!
    var directory: Directory?
    let call = "tel://"
    let mail = "mailto:"
    @IBOutlet var tableView: UITableView!
    
    var titles = ["Father", "Occupation", "City" , "State", "Country"]

    @IBOutlet var profileImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self

        // Do any additional setup after loading the view.
        nameLabel.text = directory?.name.capitalized
        profileImg.layer.cornerRadius = profileImg.frame.height / 2
        if directory?.imageData != nil {
            profileImg.image = UIImage(data: directory!.imageData!)
        } else{
            profileImg.image = UIImage(named: "profile-img")
        }
    }
    
    private func ContactVia(method: String, phoneNumber:String) {

      if let phoneCallURL = URL(string: method+phoneNumber) {

        let application:UIApplication = UIApplication.shared
        if (application.canOpenURL(phoneCallURL)) {
            application.open(phoneCallURL, options: [:], completionHandler: nil)
        }
      }
    }

    @IBAction func callTapped(_ sender: Any) {
        ContactVia(method: call, phoneNumber: directory!.mobile)
    }
    
    @IBAction func emailTapped(_ sender: Any) {
    
        ContactVia(method: mail, phoneNumber: directory!.email)
    
    }

}

extension ContactDetailViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let descs = [directory?.father, directory?.occupation, directory?.city, directory?.state, directory?.country]
        let cell = tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell") as! TitleTableViewCell
        cell.selectionStyle = .none

        cell.titleLabel.text = titles[indexPath.row]
        cell.descLabel.text = descs[indexPath.row]
        return cell
    }
    
    
    
    
}
