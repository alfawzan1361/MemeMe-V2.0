//
//  MemeTableViewController.swift
//  MemeMe-1.0
//
//  Created by AF on 9/17/19.
//  Copyright © 2019 amaf. All rights reserved.
//
import Foundation
import UIKit

class MemeTableViewController: UITableViewController {
    
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TCell")!
        let meme = self.memes[(indexPath as NSIndexPath).row]

        cell.imageView?.image = meme.memedImage
        cell.textLabel?.text = meme.topText
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let meme = memes[(indexPath as NSIndexPath).row]
        
        let detailController = self.storyboard!.instantiateViewController(withIdentifier: "VillainDetailViewController") as! VillainDetailViewController
            detailController.meme = meme
        
        self.navigationController!.pushViewController(detailController, animated: true)
    }
}
