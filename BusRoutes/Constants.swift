//
//  Constants.swift
//  BusRoutes
//
//  Created by Sergio Fraile Carmena on 07/04/2018.
//  Copyright © 2018 Sergio Fraile. All rights reserved.
//

// Constants define a global structure to store constants in
// subsections
struct Constants {
  // The subsection notifications stores the values for internal
  // use of the notification center
  struct Notifications {
    static let RoutesLoadSuccess = "routes_loaded_successfully"
    static let RoutesLoadFailure = "routes_not_loaded_error"
  }
}
