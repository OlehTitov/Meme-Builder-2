//
//  EmptyStateDelegate.swift
//  MemeBuilder
//
//  Created by Oleh Titov on 13.04.2020.
//  Copyright © 2020 Oleh Titov. All rights reserved.
//

import UIKit

class EmptyStateDelegate: NSObject, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    let textForTitle = "Make your first meme"
    let nameOfImage = "noMeme"
    let textForDescription = "Create amazing meme in a snap and share it with your friends!"
    
    
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = textForTitle
        let attrs = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .headline)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        let emptyStateImage = UIImage(named: nameOfImage)
        return emptyStateImage
    }
        
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = textForDescription
        let attrs = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .body)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
}
