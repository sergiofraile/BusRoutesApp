//
//  UIImageView+Extension.swift
//  BusRoutes
//
//  Created by Sergio Fraile Carmena on 07/04/2018.
//  Copyright © 2018 Sergio Fraile. All rights reserved.
//

import Foundation
import UIKit

// Extension for UIImageView which adds the feature of downloading an image from an url
// and assing it to the UIImageView. It also allows to display a placeholder while loading and
// features a cache functionality for quick reloading of images.

extension UIImageView {
  
  func imageFromUrl(url: URL, withPlaceholder placeholder: String?) {
    // If the placeholder is defined, we set it as an image
    if let placeholder = placeholder {
      self.image = UIImage(named: placeholder)
    }
    
    // Get the cache instance from DataManager
    let imageCache = DataManager.sharedInstance.imagesCache
    
    // If there's an image in cache for this url, we assign it to the image
    if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
      self.image = cachedImage
    } else {
      // Otherwise, we perform a data fetch from that url
      DispatchQueue.global().async {
        if let data = try? Data(contentsOf: url) {
          DispatchQueue.main.async {
            // Once downloaded, we assign the image to the UIImageView
            // and set that image in the cache
            guard let image = UIImage(data: data) else { return }
            self.image = image
            imageCache.setObject(image, forKey: url.absoluteString as NSString)
          }
        }
      }
    }
  }
  
  // When the url is in the shape of a String, we verify that is a valid url, convert it
  // and invoke the previous function imageFromUrl(url: URL, withPlaceholder placeholder: String?)
  func imageFromUrl(stringUrl: String?, withPlaceholder placeholder: String?) {
    guard let stringUrl = stringUrl, let url = URL(string: stringUrl) else { return }
      self.imageFromUrl(url: url, withPlaceholder: placeholder)
  }
}
