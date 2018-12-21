//
//  AboutPetController+ImagePickerDelegate.swift
//  CanLove
//
//  Created by Alex on 29/10/18.
//  Copyright © 2018 Techlatam. All rights reserved.
//

import Foundation
import UIKit
import TLPhotoPicker
import PhotosUI

extension AboutPetController:TLPhotosPickerViewControllerDelegate{
    
    // MARK: - TLPIckerActions
    
    func dismissPhotoPicker(withTLPHAssets: [TLPHAsset]) {
        // use selected order, fullresolution image
        
        weak var weakSelf = self
        guard let weak = weakSelf else{return}
        
        selectedAssets = withTLPHAssets
        
        
        let imageManager = PHCachingImageManager()
        let options = PHImageRequestOptions()
        options.isNetworkAccessAllowed = true
        options.isSynchronous = true
        options.resizeMode = PHImageRequestOptionsResizeMode.exact
        let targetSize = CGSize(width:800, height: 800)
        
        let assets = withTLPHAssets.compactMap({ $0.phAsset })
        for asset in assets {
            
            imageManager.requestImage(for: asset, targetSize: targetSize, contentMode: PHImageContentMode.aspectFit, options: options) { (receivedImage, info) in
                guard let image = receivedImage else { return }
                weak.selectedPrimerImage = image
                weak.primerImageView.image = image
                weak.primerImageView.isHidden = false
            }
        }
        
        
    }
    
    
    func showExceededMaximumAlert(vc: UIViewController) {
        Core.shared.alert(message: K.titles.maximumAssets, title: K.titles.alertWrongTitle, at: self)
    }
    
    
    func photoPickerDidCancel() {
        self.navigationController?.dismiss(animated: true) {}
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func didExceedMaximumNumberOfSelection(picker: TLPhotosPickerViewController) {
        self.showExceededMaximumAlert(vc: picker)
    }
    
    func handleNoAlbumPermissions(picker: TLPhotosPickerViewController) {
        picker.dismiss(animated: true) {
            Core.shared.alert(message: K.titles.albumError, title: K.titles.alertWrongTitle, at: self)
        }
    }
    
    func handleNoCameraPermissions(picker: TLPhotosPickerViewController) {
        Core.shared.alert(message: K.titles.cameraError, title: K.titles.alertWrongTitle, at: self)
    }
    
}
