//
//  ViewController.swift
//  MemeMe-1.0
//
//  Created by AF on 9/12/19.
//  Copyright © 2019 amaf. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var imagePickerView: UIImageView!
    
    @IBOutlet weak var topText: UITextField!
    @IBOutlet weak var bottomText: UITextField!
    
    @IBOutlet weak var topToolBar: UIToolbar!
    @IBOutlet weak var bottomToolBar: UIToolbar!
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        prepareTextField(textField: topText, defaultText:"TOP")
        prepareTextField(textField: bottomText, defaultText:"BOTTOM")
    }
    
    func prepareTextField(textField: UITextField, defaultText: String) {
        textField.delegate = self
        textField.text = defaultText
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = .center
        textField.backgroundColor = .clear
        textField.borderStyle = .none
    }
    
    let memeTextAttributes: [NSAttributedString.Key: Any] = [
        .strokeColor: UIColor.black,
        .foregroundColor: UIColor.white,
        .font: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        .strokeWidth:  -1.2
    ]

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        topText.clearsOnBeginEditing = true
        bottomText.clearsOnBeginEditing = true
        shareButton.isEnabled = imagePickerView.image != nil
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        if(bottomText.isEditing){
        view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }

    @IBAction func pickAnImage(_ sender: Any) {
        pickImage(sourceType: .photoLibrary)
    }

    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        pickImage(sourceType: .camera)
    }
    
    func pickImage(sourceType: UIImagePickerController.SourceType){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imagePickerView.image = image
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func save(memedImage: UIImage) {
        // Create the meme
        let meme = Meme(topText: topText.text!, bottomText: bottomText.text!, originalImage: imagePickerView.image!, memedImage: memedImage)
        (UIApplication.shared.delegate as! AppDelegate).memes.append(meme)
    }
    
    func generateMemedImage() -> UIImage {
        // TODO: Hide toolbar and navbar
        topToolBar.isHidden = true
        bottomToolBar.isHidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        // TODO: Show toolbar and navbar
        topToolBar.isHidden = false
        bottomToolBar.isHidden = false
        
        return memedImage
    }
    
    @IBAction func shareButton(_ sender: Any) {
        let memeGen = generateMemedImage()
        
        let activityViewController = UIActivityViewController(activityItems: [memeGen], applicationActivities: nil)
        activityViewController.completionWithItemsHandler = { activity, success, items, error in
            if success {
                self.save(memedImage: memeGen)
            }
        }
        activityViewController.popoverPresentationController?.sourceView = self.view
        present(activityViewController, animated: true, completion: nil)
    }
}

