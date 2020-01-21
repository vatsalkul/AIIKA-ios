//
//  DirectoryViewController.swift
//  AIIKA
//
//  Created by Vatsal Kulshreshtha on 30/12/19.
//  Copyright © 2019 Vatsal Kulshreshtha. All rights reserved.
//

import UIKit

struct Titles{
    
    let father = "father"
    let occu = "Occupation"
    let city = "city"
    
}

class DirectoryViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var searchBar: UISearchBar!
    
    lazy var refresh: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(requestData), for: .valueChanged)
        
        return refreshControl
    }()
    
    var directory = [Directory]()
    var searchName = [String]()
    var searching = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestData()
        tableView.refreshControl = refresh
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    
    
    @objc func requestData() {
        let fetchDir = fetchDirectory()

        fetchDir.fetchJson { (res) in
            switch res{
                case .success(let dir):
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    self.directory = dir!
                    self.directory.forEach({ (dir) in
                        print(dir.id)
                                
                    })
                            
                case .failure(let err):
                    print("failed to fetch", err)
            }
        }
        refresh.endRefreshing()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "cellToDetail" {
            let desVC = segue.destination as! ContactDetailViewController
            desVC.directory = sender as? Directory
        }
    }


}

extension DirectoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return directory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "dirCell") as! DirectoryTableViewCell
        
        cell.nameLabel.text = directory[indexPath.row].name.capitalized
        
        if let imageUrl = URL(string: "https://aiika-directory.s3.ap-south-1.amazonaws.com/\(directory[indexPath.row].imageUrl).jpg") {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageUrl)
                if let data = data {
                    self.directory[indexPath.row].imageData = data
                    let image = UIImage(data: data, scale: 1)
                    DispatchQueue.main.async {
                        cell.profileImageView.image = image
                    }
                } else{
                    DispatchQueue.main.async {
                        
                    cell.profileImageView.image = UIImage(named: "profile-img")
                    }
                }
                
                    
                
                
            }
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dir = directory[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "cellToDetail", sender: dir)
    }
    
    
}

extension DirectoryViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        searchName = directory.filter({ (dir) -> Bool in
//            guard let text = searchbar.text else {return false}
//            return directory.
//        })
    }
    
}
