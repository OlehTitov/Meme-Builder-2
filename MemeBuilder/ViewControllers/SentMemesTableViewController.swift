//
//  SentMemesTableViewController.swift
//  MemeBuilder
//
//  Created by Oleh Titov on 09.04.2020.
//  Copyright © 2020 Oleh Titov. All rights reserved.
//

import Foundation
import UIKit

//MARK: - CUSTOM TABLEVIEW CELL
class MemetableViewCell: UITableViewCell {
    @IBOutlet weak var memeImage: UIImageView!
    @IBOutlet weak var memeTopText: UILabel!
    @IBOutlet weak var memeBottomText: UILabel!
    @IBOutlet weak var sentDateAndTime: UILabel!
}

//MARK: - TABLEVIEWCONTROLLER
class SentMemesTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {

//MARK: - PROPERTIES
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }
    var emtptyStateDelegate = EmptyStateDelegate()
    let cellReuseIdentifier = "MemeCell"
    let detailViewControllerIdentifier = "MemeDetailViewController"
    let swipeActionDeleteText = "Delete"
    @IBOutlet weak var table: UITableView!
    
//MARK: - VIEW WILL APPEAR
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //Reload table so newly sent memes appear
        table.reloadData()
    }

//MARK: - VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        //Connect delegate responsible for showing empty state image and text
        table.emptyDataSetSource = emtptyStateDelegate
        table.emptyDataSetDelegate = emtptyStateDelegate
        table.tableFooterView = UIView()
    }
    
    //Set the number of rows in the table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    //Assign meme to cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! MemetableViewCell
        let meme = self.memes[(indexPath as NSIndexPath).row]
        cell.memeTopText?.text = meme.topText
        cell.memeImage?.image = meme.memedImage
        cell.memeBottomText?.text = meme.bottomText
        cell.sentDateAndTime?.text = meme.timeStamp
        cell.memeImage?.clipsToBounds = true
        cell.memeImage?.layer.masksToBounds = true
        cell.memeImage?.layer.cornerRadius = 8
        
        return cell
    }
    
    //Link to detail meme view
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailController = self.storyboard?.instantiateViewController(withIdentifier: detailViewControllerIdentifier) as! MemeDetailViewController
        detailController.meme = self.memes[(indexPath as NSIndexPath).row]
        self.navigationController?.pushViewController(detailController, animated: true)
    }
    
    //Setup Delete swipe action and delete meme from the array
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let contextItem = UIContextualAction(style: .destructive, title: swipeActionDeleteText) {  (contextualAction, view, boolValue) in
            let object = UIApplication.shared.delegate
            let appDelegate = object as! AppDelegate
            appDelegate.memes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])

        return swipeActions
    }
}
