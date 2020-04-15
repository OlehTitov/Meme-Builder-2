//
//  SentMemesCollectionViewController.swift
//  MemeBuilder
//
//  Created by Oleh Titov on 09.04.2020.
//  Copyright © 2020 Oleh Titov. All rights reserved.
//

import Foundation
import UIKit

//MARK: - COLLECTION VIEW CONTROLLER
class SentMemesCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {

//MARK: - PROPERTIES
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    var emptyStateDelegate = EmptyStateDelegate()
    let imageCornerRadius: CGFloat = 8
    let cellReuseIdentifier = "CustomCollectionViewCell"
    let detailViewControllerIdentifier = "MemeDetailViewController"
    let segueIdentifier = "CollectionToDetail"
    @IBOutlet weak var grid: UICollectionView!
    
    //Initiate flow layout delegate and set number of rows and spacing
    let delegate = CustomCollectionViewDelegate(numberOfItemsPerRow: 3, interItemSpacing: 4)

//MARK: - VIEW WILL APPEAR
    override func viewWillAppear(_ animated: Bool) {
        //Reload collectionview so newly sent memes appear
        grid.reloadData()
    }

//MARK: - VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Call flow layout delegate
        grid.delegate = delegate
        
        //Setup for welcome information appear instead of empty collection view
        collectionView.emptyDataSetSource = emptyStateDelegate
        collectionView.emptyDataSetDelegate = emptyStateDelegate
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! CustomCollectionViewCell
        let meme = self.memes[(indexPath as NSIndexPath).row]
        cell.cellImage?.image = meme.memedImage
        cell.cellImage?.layer.cornerRadius = imageCornerRadius
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailController = self.storyboard?.instantiateViewController(withIdentifier: detailViewControllerIdentifier) as! MemeDetailViewController
        detailController.meme = self.memes[(indexPath as NSIndexPath).row]
        performSegue(withIdentifier: segueIdentifier, sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let target = segue.destination as? MemeDetailViewController, let index = collectionView.indexPathsForSelectedItems?.first {
            
        target.meme = self.memes[index.row]
        }
    }
}
