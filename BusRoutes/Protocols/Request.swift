//
//  Request.swift
//  BusRoutes
//
//  Created by Sergio Fraile Carmena on 07/04/2018.
//  Copyright © 2018 Sergio Fraile. All rights reserved.
//


enum Result<Value> {
  case success(Value)
  case failure(Error)
}

// Request protocol that defines a Handler, being this a completion block, with an assocaited type of Response.
// This protocol also defines a peform method.
protocol Request {
  associatedtype Response
  
  typealias Handler = (Result<Response>) -> Void
  
  func perform(then handler: @escaping Handler)
}
