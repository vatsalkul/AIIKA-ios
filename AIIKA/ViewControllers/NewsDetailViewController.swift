//
//  NewsDetailViewController.swift
//  AIIKA
//
//  Created by Vatsal Kulshreshtha on 11/01/20.
//  Copyright © 2020 Vatsal Kulshreshtha. All rights reserved.
//

import UIKit
import SafariServices

class NewsDetailViewController: UIViewController {

    
    var news: News?
    
    @IBOutlet var newsImageView: UIImageView!
    
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var descLabel: UILabel!
    
    @IBOutlet var fbButton: UIButton!
    @IBOutlet var ytButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ytButton.layer.cornerRadius = 10
        fbButton.layer.cornerRadius = 10
        titleLabel.text = news?.title
        descLabel.text = news?.description
        
        if let imageUrl = URL(string: news?.image ?? "") {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imageUrl)
                if let data = data {
                    let image = UIImage(data: data, scale: 1)
                    DispatchQueue.main.async {
                        self.newsImageView.image = image
                    }
                }
            }
            
        }
        // Do any additional setup after loading the view.
    }
    @IBAction func ytTapped(_ sender: Any) {
        
        guard let url = URL(string: news?.yt ?? "") else {
            return
        }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
        
    }
    
    @IBAction func fbTapped(_ sender: Any) {
        guard let url = URL(string: news?.fb ?? "") else {
                return
            }
            let safariVC = SFSafariViewController(url: url)
            present(safariVC, animated: true)
            
        }
    
    


}
