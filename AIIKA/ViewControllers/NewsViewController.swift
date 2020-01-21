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
                print("failed to fetch", err)
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


