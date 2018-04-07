//
//  RoutesRequest.swift
//  BusRoutes
//
//  Created by Sergio Fraile Carmena on 07/04/2018.
//  Copyright © 2018 Sergio Fraile. All rights reserved.
//

import Foundation

struct RoutesRequest: Request {
  typealias Response = [Route]
  
  func perform(then handler: @escaping Handler) {
    
    let serverConfig = NSDictionary(contentsOfFile: Bundle.main.path(forResource: "ServerConfig", ofType: "plist")!)!
    let endPoint = serverConfig.object(forKey: "EndPoint") as! String
    
    guard let url = URL(string: endPoint) else { return }
    
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    
    let session = URLSession(configuration: .default)
    
    let task = session.dataTask(with: url) { (data, response, error) in
      DispatchQueue.main.async {
        if let error = error {
          handler(.failure(error))
        } else if let data = data {
          let decoder = JSONDecoder()
          do {
            let routes = try decoder.decode([Route].self, from: data)
            handler(.success(routes))
          } catch {
            handler(.failure(error))
          }
        } else {
          let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey : "Data was not retrieved from request"]) as Error
          handler(.failure(error))
        }
      }
    }
    task.resume()
  }
}
