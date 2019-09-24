//
//  VillainDetailViewController.swift
//  MemeMe-1.0
//
//  Created by AF on 9/23/19.
//  Copyright © 2019 amaf. All rights reserved.
//
import Foundation
import UIKit

class VillainDetailViewController: UIViewController {
    var meme: Meme!


    @IBOutlet weak var imageCell: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.imageCell!.image = meme.memedImage
    
    }
}
