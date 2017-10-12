 //
//  UIImageView+AsyncImageLoading.swift
//  FlickrImageGallery
//
//  Created by Alex Di Mango on 11/10/2017.
//  Copyright © 2017 Alex Di Mango. All rights reserved.
//

import Foundation
import UIKit

var imageCache = NSCache<NSString, AnyObject>()

// MARK: - UIImageView async images download

extension UIImageView {
    func setImageWithURL(url: URL) {
        self.tag = url.hashValue
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) as? UIImage {
            self.image = cachedImage
            return
        }
        DispatchQueue.global().async {
            let imageURL = url
            let imageData = try? Data(contentsOf:url)
            let image = UIImage(data: imageData!)
            imageCache.setObject(image!, forKey: url.absoluteString as NSString)
            DispatchQueue.main.async {
                if self.tag == imageURL.hashValue {
                    self.image  = image
                }
            }
        }
    }
}
