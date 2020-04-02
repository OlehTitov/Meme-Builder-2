//
//  PresentImageToImageViewExtension.swift
//  MemeBuilder
//
//  Created by Oleh Titov on 01.04.2020.
//  Copyright © 2020 Oleh Titov. All rights reserved.
//

import Foundation
import UIKit

extension MemeEditorViewController {
    
    //Ensure that picked image will display in the image view
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let selectedImage = info[.originalImage] as? UIImage {
            imageView.image = selectedImage
        }
            dismiss(animated: true, completion: nil)
        
    }
    
}
