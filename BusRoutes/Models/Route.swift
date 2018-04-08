//
//  Route.swift
//  BusRoutes
//
//  Created by Sergio Fraile Carmena on 07/04/2018.
//  Copyright © 2018 Sergio Fraile. All rights reserved.
//

import Foundation

class Route: Decodable {
  
  // MARK: Vars
  
  var id: String
  var accessible: Bool
  var imageUrl: String?
  var name: String
  var description: String
  var stops: [String]
  
  // MARK: Coding keys
  
  private enum RouteKeys: String, CodingKey {
    case id
    case accessible
    case imageUrl
    case name
    case description
    case stops
  }
  
  private enum StopKeys: String, CodingKey {
    case name
  }
  
  // MARK: Init

  required init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: RouteKeys.self)
    self.id = try container.decode(String.self, forKey: .id)
    self.accessible = try container.decode(Bool.self, forKey: .accessible)
    self.imageUrl = try container.decode(String?.self, forKey: .imageUrl) ?? nil
    self.name = try container.decode(String.self, forKey: .name)
    self.description = try container.decode(String.self, forKey: .description)
    
    self.stops = []
    var stopsNestedArray = try container.nestedUnkeyedContainer(forKey: .stops)
    while (!stopsNestedArray.isAtEnd) {
      let stopContainer = try stopsNestedArray.nestedContainer(keyedBy: StopKeys.self)
      let stopName = try stopContainer.decode(String.self, forKey: .name)
      self.stops.append(stopName)
    }
  }
}
