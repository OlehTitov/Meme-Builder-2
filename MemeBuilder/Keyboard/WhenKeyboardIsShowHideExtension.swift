//
//  WhenKeyboardIsShowHide.swift
//  MemeBuilder
//
//  Created by Oleh Titov on 01.04.2020.
//  Copyright © 2020 Oleh Titov. All rights reserved.
//

import Foundation
import UIKit

extension MemeEditorViewController {
    
    //Start tracking when keyboard appears
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //Stop tracking when keyboard appears
    func unsubscribeFromKeyboardNotifications() {
        //Remove all notification without specifying exact name
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        //Move the entire view up if the bottom textfield is edited
        if bottomTextField.isEditing {
            view.frame.origin.y -= getKeyboardHeight(notification)
            //toolbar.isOpaque = true
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        //Return image view to its normal place
        view.frame.origin.y = 0
    }

    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
}
