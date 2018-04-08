//
//  DataManager.swift
//  BusRoutes
//
//  Created by Sergio Fraile Carmena on 07/04/2018.
//  Copyright © 2018 Sergio Fraile. All rights reserved.
//

import Foundation
import UIKit

class DataManager {
  
  // MARK: Static constants
  
  static let sharedInstance = DataManager()
  
  // MARK: Constants
  
  let apiEndPoint = "http://www.mocky.io/v2/5a0b474a3200004e08e963e5"
  let routesRequest = RoutesRequest()
  let imagesCache = NSCache<NSString, UIImage>()
  
  // MARK: Variables
  
  var busRoutes: [Route] = []
  
  // MARK: Fetch methods
  
  func fetchRoutes() {
    routesRequest.perform { result in
      switch result {
      case .success(let routes):
        self.busRoutes = routes
        NotificationCenter.default.post(name: Notification.Name(rawValue: Constants.Notifications.RoutesLoadSuccess), object: nil)
        break
      case .failure(let error):
        NSLog("Error fetching: \(error.localizedDescription)")
        NotificationCenter.default.post(name: Notification.Name(rawValue: Constants.Notifications.RoutesLoadFailure), object: nil)
        break
      }
    }
  }

}
