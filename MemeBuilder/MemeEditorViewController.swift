//
//  MemeEditorViewController.swift
//  MemeBuilder
//
//  Created by Oleh Titov on 31.03.2020.
//  Copyright © 2020 Oleh Titov. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

//MARK: - PROPERTIES
    var memedImage: UIImage! = nil
    let dismissKeyboardDelegate = DismissKeyboardDelegate()
    

//MARK: - OUTLETS
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
//MARK: - VIEW WILL APPEAR
    override func viewWillAppear(_ animated: Bool) {

        super.viewWillAppear(animated)
        //Start tracking if keyboard appears
        subscribeToKeyboardNotifications()
        disableCameraButtonIfDeviceHasNoCamera()
    }

//MARK: - VIEW WILL DISAPPEAR
    override func viewWillDisappear(_ animated: Bool) {

        super.viewWillDisappear(animated)
        //Stop tracking if keyboard appears
        unsubscribeFromKeyboardNotifications()
        
    }
    
//MARK: - VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        delegateTextFieldsToDismissKeyboard()
        applyDefaultTextFieldAttributes()
        setPlaceholderTopAndBottomText()
        setPlaceholderImage()
        setImageViewBackgroundColor()
    }
//MARK: - ACTIONS
    @IBAction func pickFromCamera(_ sender: Any) {
        callImagePickerController(.camera)
    }
    
    @IBAction func pickFromLibrary(_ sender: Any) {
        callImagePickerController(.photoLibrary)
    }
    
    @IBAction func shareMemeButton(_ sender: Any) {
        shareMeme()
    }
    @IBAction func cancelButton(_ sender: Any) {
        resetMeme()
    }
    
//MARK: - FUNCTIONS
    func applyDefaultTextFieldAttributes() {
        bottomTextField.defaultTextAttributes = TextAttributes.memeTextAttributes
        topTextField.defaultTextAttributes = TextAttributes.memeTextAttributes
        topTextField.textAlignment = NSTextAlignment.center
        bottomTextField.textAlignment = NSTextAlignment.center
    }
    
    func setPlaceholderTopAndBottomText() {
    
        topTextField.attributedPlaceholder = NSAttributedString(string: "TOP TEXT", attributes: TextAttributes.memeTextAttributes)
        bottomTextField.attributedPlaceholder = NSAttributedString(string: "BOTTOM TEXT", attributes: TextAttributes.memeTextAttributes)
    }
    
    func setPlaceholderImage() {
        imageView.image = UIImage(named: "sunflower")
        
    }
    
    func setImageViewBackgroundColor() {
        imageView.backgroundColor = UIColor.black
    }
    
    func callImagePickerController(_ source: UIImagePickerController.SourceType) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = source
        present(pickerController, animated: true, completion: nil)
    }
    
    func disableCameraButtonIfDeviceHasNoCamera() {
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    func resetMeme() {
        topTextField.text = ""
        bottomTextField.text = ""
        setPlaceholderImage()
    }
    
    func delegateTextFieldsToDismissKeyboard() {
        self.topTextField.delegate = dismissKeyboardDelegate
        self.bottomTextField.delegate = dismissKeyboardDelegate
    }
    
    func hideToolbarAndNavbar() {
        navigationController?.isNavigationBarHidden = true
        toolbar.isHidden = true
    }
    
    func showToolbarAndNavbar() {
        navigationController?.isNavigationBarHidden = false
        toolbar.isHidden = false
    }
    
    func memeGenerator() -> UIImage {
        
        hideToolbarAndNavbar()
        
        let renderer = UIGraphicsImageRenderer(size: view.bounds.size)
        memedImage = renderer.image { ctx in
            view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        }
        
        showToolbarAndNavbar()

        return memedImage
    }
    
    func save() {
        _ = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imageView.image!, memedImage: memedImage)
    }
    
    func shareMeme() {
        let generatedImage = memeGenerator()
        let item = [generatedImage]
        let shareController = UIActivityViewController(activityItems: item as [Any], applicationActivities: nil)
        present(shareController, animated: true)
        
        //Enable popover for Ipad
        if let popOver = shareController.popoverPresentationController {
        popOver.sourceView = self.view
        }
        
        shareController.completionWithItemsHandler = {
            (activityType, completed, returnedItems, error) -> Void in
            if completed {
                self.save()
                self.resetMeme()
            }
        }
    }
    
}

