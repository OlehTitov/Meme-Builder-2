//
//  TextFieldAttributes.swift
//  MemeBuilder
//
//  Created by Oleh Titov on 02.04.2020.
//  Copyright © 2020 Oleh Titov. All rights reserved.
//

import Foundation
import UIKit

struct TextAttributes {
    
   //Define the style of the text in meme
    static var memeTextAttributes: [NSAttributedString.Key: Any] = [
        NSAttributedString.Key.strokeColor: UIColor.black,
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 50)!,
        NSAttributedString.Key.strokeWidth:  -3.0,
    ]
}

