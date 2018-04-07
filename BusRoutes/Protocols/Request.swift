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

protocol Request {
  associatedtype Response
  
  typealias Handler = (Result<Response>) -> Void
  
  func perform(then handler: @escaping Handler)
}
