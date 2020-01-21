//
//  NewsViewController.swift
//  AIIKA
//
//  Created by Vatsal Kulshreshtha on 29/12/19.
//  Copyright © 2019 Vatsal Kulshreshtha. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private var allNews = [News]()

        
    @IBOutlet weak var tableView: UITableView!
    
    var nCount: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fetch = fetchNews()
        
        fetch.fetchJson { (res) in
            switch res{
            case .success(let news):
                DispatchQueue.main.async {
                    self.tableView.reloadData()

                }
                self.allNews = news!.News
                self.allNews.forEach({ (news) in
                    print(news.id)
                    
                })
//                news?.forEach( {(news) in
//                    print(news.id)
//
//                })
                
            case .failure(let err):
                print(err)
                DispatchQueue.main.async {
                    self.tableView.setEmptyView(title: "Sorry", message: "Failed to fetch data")
                }
            }
            
        }
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "newsToDetail" {
            let desVC = segue.destination as! NewsDetailViewController
            desVC.news = sender as? News
        }
    }

     
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           
        if allNews.count == 0 {
            tableView.restore()
        tableView.setEmptyView(title: "No News available.", message: "Kindly wait for updates")
        }
        else {
        tableView.restore()
        }
        return allNews.count

       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? DataTableViewCell else {return UITableViewCell()}
           
        
        if let imageUrl = URL(string: allNews[indexPath.row].image) {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageUrl)
                if let data = data {
                    let image = UIImage(data: data, scale: 1)
                    DispatchQueue.main.async {
                        cell.newsImageView.image = image
                    }
                }
            }
            
        }
        cell.label.text = String(allNews[indexPath.row].title)
        
           
           return cell
       }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let news = allNews[indexPath.row]
            tableView.deselectRow(at: indexPath, animated: true)
            performSegue(withIdentifier: "newsToDetail", sender: news)
        
    }
       
    
}
       
       
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


extension UITableView {
    func setEmptyView(title: String, message: String) {
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        messageLabel.textColor = UIColor.lightGray
        messageLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)
        titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20).isActive = true
        titleLabel.text = title
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        // The only tricky part is here:
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
        }
}
