//
//  ImageSaver.swift
//  Instafilter
//
//  Created by Bosco on 21/02/2020.
//  Copyright © 2020 Bosco Ybarra. All rights reserved.
//

import UIKit

class ImageSaver: NSObject {
//  In order for that result to be useful we need to make it propagate upwards so that our ContentView can use it. However, I don’t want the evil horrors of @objc to escape our little class, so instead we’re going to isolate that mess where it is and instead report back success or failure using closures – a much friendlier solution for Swift developers.
    var successHandler: (() -> Void)?
    var errorHandler: ((Error) -> Void)?
    
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }

    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        // save complete
        if let error = error {
            errorHandler?(error)
        } else {
            successHandler?()
        }
    }
}
