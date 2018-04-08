//
//  UIImageView+Extension.swift
//  BusRoutes
//
//  Created by Sergio Fraile Carmena on 07/04/2018.
//  Copyright © 2018 Sergio Fraile. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
  func imageFromUrl(url: URL, withPlaceholder placeholder: String?) {
    if let placeholder = placeholder {
      self.image = UIImage(named: placeholder)
    }
    
    let imageCache = DataManager.sharedInstance.imagesCache
    
    if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
      NSLog("Cached image")
      self.image = cachedImage
    } else {
      NSLog("=== Not cached image url: \(url.absoluteString)")
      DispatchQueue.global().async {
        if let data = try? Data(contentsOf: url) {
          DispatchQueue.main.async {
            guard let image = UIImage(data: data) else { return }
            self.image = image
            imageCache.setObject(image, forKey: url.absoluteString as NSString)
            NSLog("Image saved")
          }
        }
      }
    }
  }
  
  func imageFromUrl(stringUrl: String?, withPlaceholder placeholder: String?) {
    guard let stringUrl = stringUrl, let url = URL(string: stringUrl) else { return }
      self.imageFromUrl(url: url, withPlaceholder: placeholder)
  }
}
