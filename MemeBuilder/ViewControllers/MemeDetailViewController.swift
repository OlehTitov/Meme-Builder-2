//
//  MemeDetailViewController.swift
//  MemeBuilder
//
//  Created by Oleh Titov on 10.04.2020.
//  Copyright © 2020 Oleh Titov. All rights reserved.
//

import Foundation
import UIKit

class MemeDetailViewController: UIViewController {
    
    var meme : Meme!
    
    @IBOutlet weak var detailView: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        detailView.image = meme.memedImage
    }
}
