//
//  MemeCollectionViewController.swift
//  MemeMe-1.0
//
//  Created by AF on 9/17/19.
//  Copyright © 2019 amaf. All rights reserved.
//
import Foundation
import UIKit

class MemeCollectionViewController: UICollectionViewController {
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CCell", for: indexPath) as! VillainCollectionViewCell
        
        let meme = self.memes[(indexPath as NSIndexPath).row]
        cell.imageCCell.image = meme.memedImage
        cell.labelCCell.text = meme.topText

        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath:IndexPath) {
        
        let meme = memes[(indexPath as NSIndexPath).row]

        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "VillainDetailViewController") as! VillainDetailViewController
            detailController.meme = meme

        navigationController!.pushViewController(detailController, animated: true)
    }
}
