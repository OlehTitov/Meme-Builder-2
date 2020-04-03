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
        .strokeColor: UIColor.black,
        .foregroundColor: UIColor.white,
        .font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 50)!,
        .strokeWidth:  -3.0,
    ]
}

