//
//  ShotsGridController.swift
//  iShotsApp
//
//  Created by yuye wang on 3/21/15.
//  Copyright (c) 2015 yuye wang. All rights reserved.
//

import Foundation


import UIKit

class ShotsGridController : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var collectionView : UICollectionView!
    
    @IBOutlet var layout : UICollectionViewFlowLayout!
    
    

    var shots :[Shot]!
    var cellHeight : CGFloat = 240
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "iShots"
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clearColor()
        
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        let cellWidth = self.view.frame.width/2
        layout.itemSize = CGSizeMake(cellWidth, cellHeight)
        
        shots = [Shot]()
        let api = DribbbleAPI()
        api.loadShots(didLoadShots)
    
    }
    
    
    func didLoadShots(shots: [Shot]){
        self.shots = shots
        collectionView.reloadData()
    
    }
    
   
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ShotCell", forIndexPath: indexPath) as ShotCell
        //拿到shot cell以后
        let shot = shots[indexPath.row]
        cell.titleLabel.text = shot.title
        cell.nameLabel.text = shot.user.name
        asyncLoadShotImage(shot, imageView: cell.coverImageView)
        
        
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shots.count
    }
    
    
    func asyncLoadShotImage(shot: Shot, imageView : UIImageView){
        
        let downloadQueue = dispatch_queue_create("com.wangyuye.processdownload", nil)
        
        dispatch_async(downloadQueue){
            var data = NSData(contentsOfURL: NSURL(string: shot.imageUrl)!)
            var image : UIImage?
            if data != nil {
                shot.imageData = data
                image = UIImage(data: data!)!
            }
            
            dispatch_async(dispatch_get_main_queue()){
                imageView.image = image
            }
        }
    }

}