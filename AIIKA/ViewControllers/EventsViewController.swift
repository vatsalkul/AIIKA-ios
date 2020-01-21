//
//  EventsViewController.swift
//  AIIKA
//
//  Created by Vatsal Kulshreshtha on 03/01/20.
//  Copyright © 2020 Vatsal Kulshreshtha. All rights reserved.
//

import UIKit
import UPCarouselFlowLayout


class EventsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    

    @IBOutlet var collectionView: UICollectionView!
    
    var events = Events.fetchEvents()
    let cellScale: CGFloat = 0.8
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let flowLayout = UPCarouselFlowLayout()
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width - 60, height: collectionView.frame.size.height - 100)
        flowLayout.scrollDirection = .horizontal
        flowLayout.sideItemScale = 0.8
        flowLayout.sideItemAlpha = 1.0
        flowLayout.spacingMode = .fixed(spacing: 5.0)
        collectionView.collectionViewLayout = flowLayout
        
        
//        let screenSize = UIScreen.main.bounds.size
//        let cellWidth = floor(screenSize.width * cellScale)
//        let cellHeight = floor(screenSize.height * cellScale)
//        let insetX = (view.bounds.width - cellWidth) / 2.0
//        let insetY = (view.bounds.height - cellHeight) / 2.0
//
//        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
//
//        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
//        collectionView.contentInset = UIEdgeInsets(top: insetY, left: insetX, bottom: insetY, right: insetX)
        
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventsCollectionViewCell", for: indexPath) as! EventsCollectionViewCell
        
        let event = events[indexPath.item]
        
        cell.Events = event
        
        return cell
        
    }
    

  

}
