//
//  CustomCamera.swift
//  DKImagePickerControllerDemo
//
//  Created by ZhangAo on 03/01/2017.
//  Copyright © 2017 ZhangAo. All rights reserved.
//

import UIKit
import MobileCoreServices

open class CustomCamera: UIImagePickerController, DKImagePickerControllerCameraProtocol, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var didCancel: (() -> Void)?
    var didFinishCapturingImage: ((_ image: UIImage?, _ data: Data?) -> Void)?
    var didFinishCapturingVideo: ((_ videoURL: URL) -> Void)?
    
    public func setDidCancel(block: @escaping () -> Void) {
        self.didCancel = block
    }
    
    public func setDidFinishCapturingImage(block: @escaping (UIImage?, Data?) -> Void) {
        self.didFinishCapturingImage = block
    }
    
    public func setDidFinishCapturingVideo(block: @escaping (URL) -> Void) {
        self.didFinishCapturingVideo = block
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        self.sourceType = .camera
        self.mediaTypes = [kUTTypeImage as String, kUTTypeMovie as String]
    }
    
    // MARK: - UIImagePickerControllerDelegate methods

    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! String

        if mediaType == kUTTypeImage as String {
            let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            self.didFinishCapturingImage?(image, nil)
        } else if mediaType == kUTTypeMovie as String {
            let videoURL = info[UIImagePickerController.InfoKey.mediaURL] as! URL
            self.didFinishCapturingVideo?(videoURL)
        }
    }
    
    open func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.didCancel?()
    }
    
}
