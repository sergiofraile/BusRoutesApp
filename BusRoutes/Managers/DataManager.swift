//
//  DataManager.swift
//  BusRoutes
//
//  Created by Sergio Fraile Carmena on 07/04/2018.
//  Copyright © 2018 Sergio Fraile. All rights reserved.
//

import Foundation
import UIKit

// Signleton class to handle data loads and caching.
// This DataManager can accept modules to handle the different parts of the API. In
// this case, there's attached a RoutesRequest module that will contain the
// require methods and information to perform the fetch request.
// Additional modules could be included to extend the DataManager to different APIs.
//
// The imagesCaches is used in UIImageView+Extension.swift

class DataManager {
  
  // MARK: Static constants
  
  static let sharedInstance = DataManager()
  
  // MARK: Constants
  
  lazy var routesRequest = RoutesRequest()
  let imagesCache = NSCache<NSString, UIImage>()
  
  // MARK: Variables
  
  var busRoutes: [Route] = []
  
  // MARK: Fetch methods
  
  // Fetch the routes through the RoutesRequest struct. RoutesRequest allows
  // to kind of server responses to easily iterate through them with a switch
  // operation.
  func fetchRoutes() {
    routesRequest.perform { result in
      switch result {
      case .success(let routes):
        // Routes have been loaded, so we assign them and notify the rest of the application.
        self.busRoutes = routes
        // This notification is being observed in RoutesViewController.swift
        NotificationCenter.default.post(name: Notification.Name(rawValue: Constants.Notifications.RoutesLoadSuccess), object: nil)
        break
      case .failure(let error):
        // There was an error fetching the routes.
        NSLog("Error fetching: \(error.localizedDescription)")
        // This notification is being observed in RoutesViewController.swift
        NotificationCenter.default.post(name: Notification.Name(rawValue: Constants.Notifications.RoutesLoadFailure), object: nil)
        break
      }
    }
  }

}
