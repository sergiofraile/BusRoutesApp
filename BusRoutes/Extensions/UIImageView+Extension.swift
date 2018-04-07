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
    
    DispatchQueue.global().async {
      if let data = try? Data(contentsOf: url) {
        DispatchQueue.main.async {
          self.image = UIImage(data: data)
        }
      }
    }
  }
  
  func imageFromUrl(stringUrl: String?, withPlaceholder placeholder: String?) {
    if let placeholder = placeholder {
      self.image = UIImage(named: placeholder)
    }
    
    guard let stringUrl = stringUrl, let url = URL(string: stringUrl) else { return }
    
    DispatchQueue.global().async {
      if let data = try? Data(contentsOf: url) {
        DispatchQueue.main.async {
          self.image = UIImage(data: data)
        }
      }
    }
  }
}
