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
        disableCameraButtonIfDeviceHasNoCamera()
        setupTextFieldStyle(toTextField: topTextField, defaultText: "TOP TEXT")
        setupTextFieldStyle(toTextField: bottomTextField, defaultText: "BOTTOM TEXT")
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
    func setupTextFieldStyle(toTextField textField: UITextField, defaultText: String) {
        textField.defaultTextAttributes = TextAttributes.memeTextAttributes
        textField.textAlignment = NSTextAlignment.center
        textField.attributedPlaceholder = NSAttributedString(string: defaultText, attributes: TextAttributes.memeTextAttributes)
        textField.delegate = dismissKeyboardDelegate
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
    
    func hideToolbars(_ hide: Bool) {
        navigationController?.isNavigationBarHidden = hide
        toolbar.isHidden = hide
    }

    func memeGenerator() -> UIImage {
        hideToolbars(true)
        let renderer = UIGraphicsImageRenderer(size: view.bounds.size)
        memedImage = renderer.image { ctx in
            view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        }
        hideToolbars(false)
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

